#Partner: Varun Kolli


.globl ISR
ISR:
	csrrw zero, 64, zero #initialize ssp to 0
	la a0, handler #get the address of the handler
	csrrw zero, 5, a0 #set utvec to the handler's address
	li a0, 0x100
	csrrs zero, 4, a0 #enable user-level interrupt / device interrupt 
	csrrsi zero, 0, 1 #enable gloabl interupt by setting ustatus to 1
	b pMessage

pMessage: #this prints the message "Initializing Interrupts"
	la a0, initializingInterrupts
	
pString:
	lw a5, TCR
	lw a3, (a5)
	andi a4, a4, 0
	addi a4, a4, 1
	bne a3, a4, pString
	lw a5, TDR
	lb a6, (a0) #load current byte from the address
	sb a6, (a5) 
	addi a0, a0, 1 #add 1 to the address of the string to point to the next byte 
	beqz a6, exitString
	b pString

exitString:
	ret

handler:
	csrrw s1, 66, zero #load the value of our ucause into s1
	srli s1, s1, 31 #right shift the value of ucause by 31 times to see what the 31 bit is
	beqz s1, pException #if the value of s1 is 0, it means that we caught an exception and not an interrupt

	addi a2, a2, 1 #this increment our counter of key presses by 1
	csrrw sp, 64, sp #swap the sp and ssp
	addi sp, sp, -16 
	sb ra, 12(sp) #save return address to the stack
	sw a1, 8(sp) #save a1 to the stack

	la a7, keyPressed 

pCharacterPressed:
	lw a5, TCR
	lw a3, (a5)
	andi a4, a4, 0
	addi a4, a4, 1
	bne a3, a4, pCharacterPressed
	lw a5, TDR
	lb a6, (a7) #load current byte from the address
	sb a6, (a5) 
	addi a7, a7, 1 #add 1 to the address of the string to point to the next byte 
	beqz a6, pCharacter
	b pCharacterPressed


pCharacter:
	lw a5, TCR
	lw a3, (a5)
	andi a4, a4, 0
	addi a4, a4, 1
	bne a3, a4, pCharacter
	lw a5, TDR
	lb s2, (a0)
	sb s2, (a5)

	andi t4, t4, 0 #clears the register that we used to hold our character to print
	add t4, s2, t4 #set the new character to print to the key we pressed


pNewLine:
	la a7, newline
	lw a5, TCR
	lw a3, (a5)
	andi a4, a4, 0
	addi a4, a4, 1
	bne a3, a4, pNewLine
	lw a5, TDR
	lb s2, (a7)
	sb s2, (a5)

	lb ra, 12(sp) #restore the value of the return address that we saved
	lb a1, 8(sp) #restore the value of a1 that we saved
	addi sp, sp, 16
	csrrw sp, 64, sp #swap the sp and ssp back
	uret #return code for exception/interrupt

pException: 
	la a7, causedByException
	
printingException:
	lw a5, TCR
	lw a3, (a5)
	andi a4, a4, 0
	addi a4, a4, 1
	bne a3, a4, printingException
	lw a5, TDR
	lb a6, (a7) #load current byte from the address
	sb a6, (a5) 
	addi a7, a7, 1 #add 1 to the address of the string to point to the next byte 
	beqz a6, exitException
	b printingException

exitException: #once exception message is done printing, return to where we came from
	b exitString

.globl RCR
.globl RDR
.globl TCR
.globl TDR
.data
initializingInterrupts: .asciz "\nInitializing Interrupts\n"
caausedByInterrupt: 	.asciz "\nUnhandled Interrupt\n"
causedByException: 	.asciz "\nUndetermined Exception\n"
keyPressed: 		.asciz "\nkey pressed is: "
RCR:			.word 0xffff0000 #address of RCR
RDR:			.word 0xffff0004 #address of RDR
TCR:			.word 0xffff0008 #address of TCR
TDR: 			.word 0xffff000c #address of TDR
test:			.asciz "interrupt happened"
newline: 		.asciz "\n"

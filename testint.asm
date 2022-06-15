#Partner: Varun Kolli


.globl shiftBit
.globl main
main:
	andi t4, t4, 0 #clear t4
	addi t4, t4, 42 #this is the ascii value for asterisk
	andi a2, a2, 0 #use a2 as the counter to see how many times a key has been pressed
	li t3, 5 #use this as a condition to check if a2 is equal to 5
	jal ra, ISR #jump to ISR to set up the interrupt bits
	li a1, 2 #let a1 hold the value of 2
	lw t5, RCR #let t5 hold the RCR
	sw a1, (t5) #set bit 2 of the RCR to enable interrupt
	lw a0, RDR #let a0 hold the RDR; the character that we typed

	

shiftBit:
	beqz t6, pAsterisk
	beq a2, t3, main 	#if 5 keys are pressed, repeat program
	srli t6, t6, 1 		#shift by 1 to right
	b shiftBit		#loop back



.data 
RCR:.word 0xffff0000
RDR:.word 0xffff0004
TCR:.word 0xffff0008
TDR:.word 0xffff000c

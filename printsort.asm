
.text
la a0, query
li a7, 4
ecall

li t0, 0xa #the enter char
li t1, 0x10010000
li t2, 0
la a0, space #set it to space so we can check if the key is "space"
li a1, 20 #set it to 20 to check if the word is less than 20 chars
li a7, 12 #set ecall to readChar
li a6, 0x10010014 

while:
	ecall
	beq a0, t0, endwhile #if t0 is equal to a space, send it endwhile
	
	sb a0, (t1) #if not, store the char
	addi t1, t1, 1 #increment forward
	
	bne a0, t0, while #send it back up

endwhile:
while2:
	sb x0, (t1) #set the rest to zero
	addi t1, t1, 1 #increment forward
	blt t1, t4, while2 
endwhile2:
	la a0, printStatement #print out the beginning statement
	li a7, 4 #set the ecall to printChar
	ecall
	li t1, 0x10010000 #reset the address
	li t0, 0 #set counter for the for-loop
	li t2, 0xFFF #current low
	li t3, 0x0 #absolute lowest
	li t4, 0x10010014 #set the comparison for the for-loop
	li t5, 0 #set the current bit in the word
	li a7, 11
	li t6, 0xFFF
	
while3:
	li t1, 0x10010000 
	li t2, 0xFFF 
	for2:
		lb t5, (t1) #load the current char i
		if:
			beq t5, x0, endfor2 #end of loop
			bge t5, t2, endif #if smaller than the current lowest
			ble t5, t3, endif #if char has already been done
			add t2, t5, x0 #set the lowest right now to the current number
		endif:
			addi t1, t1, 1
			blt t1, t4, for2 
	endfor2:
		beq t2, t6, endwhile3
		add t3,  t2, x0
		add, a0, t2, x0
		ecall
		bgt t2, x0, while3
endwhile3:



.data 

query: .string "\nInsert Word:"
printStatement: .string "\nAlphabetized Word: "
space: .space 20
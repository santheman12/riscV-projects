mergeStrings:

	addi t0, a1, 0 #put string one into a register
	addi t1, a2, 0 #put string two into a register
	li t2, 0x0 #even or odd counter
	li t3, 1 #mask for even or odd counter
	li a7, 11 #ecall to print
	while:
		and t4, t2, t3 #set counter to 0 or 1
		if:
			beq t4, t3, endIf #if counter is one (odd) then go to endif
			lb t5, (t0) #takes the current byte of the first string	
			if2:
				beq t5, x0, endIf2 #check if char is null
				add a0, x0, t5 #load the char in t5 to a0
				ecall #to print
				addi t0, t0, 1 #increment printer for string one
			endIf2:
				b endIf3 #get to the end
				
		endIf:
			lb t5, (t0) #takes the current byte of the first string	
			if3:
				beq t5, x0, endIf3 #check if char is null
				add a0, x0, t5 #load the char in t5 to a0
				ecall #to print
				addi t1, t1, 1 #increment printer for string two
			endIf3:
				
			
		addi t2, t2, 1 #increment the counter
		lb t5, (t0) #pull the char of the first string
		bne x0, t5, while #check the char of the first string to see if it null, it it isn't send it back to while loop
		lb t5, (t1) #pull the char from the second string
		bne t5, x0, while #check the char of the second string to see if it null, it it isn't send it back to while loop
		
		
	endWhile:
	
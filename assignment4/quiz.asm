.text 

.globl main

main:
	li a1, 0x10010000

	li t2, 0 #set counter for memory
	li t6, 0 #total num of points
	
	li s1, 1
	li s2, 2
	li s3, 3
	li s4, 4
	li s5, 5
	li s6, 6
	li s7, 7
	li s8, 8
	li s9, 9
	
	
	jal askName
	jal Question1
	jal question1Points
	
	addi t0, t0, 4 #to increment the memory
	
	jal Question2
	jal question2Points
	
	addi t0, t0, 4
	
	jal Question2
	jal question3Points
	
	jal results	
	b end
	

Question1:
	la t0, QuestionTable
	mv s0, ra
	jal prompt
	li a7, 11 #set ecall to print
	ecall
	mv ra, s0
	
Question2:
	mv s0, ra
	jal ra, prompt
	li a7, 11 #set ecall to print
	ecall
	mv ra, s0
	ret
	
	
question1Points:
	mv s7, t0
	la t0, Q1Answ
	
	case1q1:
		beq a0, s1, endQuestion1
	case2q1:
		addi t0, t0, 4
		beq a0, s2, endQuestion1
	case3q1:
		addi t0, t0, 4
		beq a0, s3, endQuestion1
	case4q1:
		addi t0, t0, 4
		beq a0, s4, endQuestion1
	endQuestion1:
		lw t3, (t0)
		add t6, t3, t6
		mv t0, s7
		ret
		
	
question2Points:
	mv s7, t0
	la t0, Q2Answ
	
	case1q2:
		beq a0, s1, endQuestion2
	case2q2:
		addi t0, t0, 4
		beq a0, s2, endQuestion2
	case3q2:
		addi t0, t0, 4
		beq a0, s3, endQuestion2
	case4q2:
		addi t0, t0, 4
		beq a0, s4, endQuestion2
	endQuestion2:
		lw t3, (t0)
		add t6, t3, t6
		mv t0, s7
		ret

question3Points:
	mv s7, t0
	la t0, Q3Answ
	
	case1q3:
		beq a0, s1, endQuestion3
	case2q3:
		addi t0, t0, 4
		beq a0, s2, endQuestion3
	case3q3:
		addi t0, t0, 4
		beq a0, s3, endQuestion3
	case4q3:
		addi t0, t0, 4
		beq a0, s4, endQuestion3
	endQuestion3:
		lw t3, (t0)
		add t6, t3, t6
		mv t0, s7
		ret
	
askName:
	la a0, nameq
	mv t1, a1
	li t0, 0xa #if enter is pressed 
	li a7, 4 #for the ecall to print
	ecall 
	li a7, 12 # to read the name of the user
	
	while:
		ecall
		beq a0, t0, endwhile #keep going until the the key is not enter
		sb a0, (t1) #update
		addi t1, t1, 1 #increment
		bne a0, t0, while #if not equal go back up
	endwhile:
		ret

prompt:
	lw a0, 0(t0)
	li a7, 4 #set ecall to print the string
	ecall 
	li a7, 5 #set ecall to read it
	ecall 
	
results:
	la t0, ResultTable #put it all in t0
	blt t6, s5, caseFinal1 
	blt t6, s6, caseFinal2
	blt t6, s8, caseFinal3
	b caseFinal4 #else
	
	caseFinal1:
		la a0, Result1
		li a7, 4
		ecall
		li a0, 0x10010000
		ecall
	caseFinal2:
		la a0, Result2
		li a7, 4
		ecall
		li a0, 0x10010000
		ecall
	caseFinal3:
		la a0, Result3
		li a7, 4
		ecall
		li a0, 0x10010000
		ecall
	caseFinal4:
		la a0, Result4
		li a7, 4
		ecall
		li a0, 0x10010000
		ecall
end:
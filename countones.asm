#Question 1: 0xabcdef00
#Question 2: Register x2 is a pointer to the memory of the number we're trying to add
#Question 3: We increment by four because each word takes up four spaces, incrementing by one will give you a different part of the same word
#Question 4: x4 is equal to 10 because the loop iterates through 10 times.


#x1 = word stored in memory location 0x10010000
#x2 = interator for the loop
#x3 = count of 1's in x1
#x4 = temp to check if the right bit is 1
#x5 = to save the final result in
#x6 = total amount of time the loop will run
#x7 = the memory location to store it in the end
#x8 = to add one or a zero

.text
.globl main

main:
	li x1, 0x10010000 # x1 = memory location in 0x10010000
	lw x2, (x1) #get the value in the memory location
	li x3, 0 #set the counter to zero
	li x4, 0 #set the counter for number of ones to zero
	li x5, 1 # will be used for AND bitwise
	li x6, 32 #set it equal to 32
	li x7, 0x10010004 #location to store in 
	
forLoop:
	
	if:
		and x8, x2, x5 #binary AND.
		beqz x8, endIf #if it's equal to 0, then go to endIf (basically out of the if-loop)
		addi x4, x4, 1 #increment the number of 1's
		
	endIf:
	
	addi x3, x3, 1 #increament the counter for the loop
	srli x2, x2, 1 #move to the next bit to the right
	blt x3, x6, forLoop #go again in the loop if it's less than 32


sw x4, (x7)

	
	
		
		
		
	
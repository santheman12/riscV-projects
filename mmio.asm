.globl pAsterisk
pAsterisk: 
	lw   t1, TCR			#load TCR address
	lw   t0, (t1)			#load into TCR
	andi t2, t2, 0			#counter reset
	addi t2, t2, 1			#counter addition
	bne  t0, t2, pAsterisk	#loop back 
	lw   t1, TDR			#load in TDR address
	mv t0, t4			#move address to t4
	beq a2, t3, main	 	#restart if 5 keys pressed
	sb   t4, (t1) 			#write asterisk
	li t6, 1			#load ready value into t6
	b shiftBit			#loops back
	



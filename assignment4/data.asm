.data

#this structure is common in assembly and C. Notice that Q1 is not global, but is an entry in a table. 
#label addresses can be "encoded" as the value of a .word

.globl QuestionTable
.globl nameq

nameq: .string "What is your name?"

QuestionTable:
	.word	Q1 Q2 Q3

Q1:      .string  "\nWhat is your favorite food?\n   1 - Pizza\n   2 - Thai\n   3 - Sushi\n   4 - Firestone\n"
Q2:    	 .string  "\nWhat is your favorite TV show?\n   1 - Law & Order\n   2 - Scrubs\n   3 - Survivor\n   4 - Elimidate\n"
Q3:    	 .string  "\nWho is your favorite professor?\n   1 - Professor MonkeyForaHead\n   2 - Professor from Gilligan's Island\n   3 - Nutty Professor\n   4 - John Planck\n"

#or just have a bunch of .globl directives.
.globl Q1Answ Q2Answ Q3Answ 
Q1Answ:  .word    2
         .word    5
         .word    10
         .word    8

Q2Answ:  .word    8 10 5 2  #is this different from Q1Answ? (no)
Q3Answ:  .word    5 8 2 10

.globl ResultTable
.globl Result1
.globl Result2
.globl Result3
.globl Result4
ResultTable:
         .word Result1	
         .word Result2
         .word Result3	
         .word Result4	

Result1:	.string  "\nTerrible! You get an 'F'!"
Result2:	.string  "\nHmm, I thought your mother raised you better."
Result3:	.string  "\nNot bad, kid.  You have good taste."
Result4:	.string  "\nExcellent!  Julie, is that you???"
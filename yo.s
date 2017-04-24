.global main
.func main
   
main:
    PUSH {R3}
    PUSH {R4}  @ backup R4 and R5
    PUSH {R5}

    BL  _scanf              @ branch to scanf procedure with return
    MOV R1, R0	       	@ obtained first number in R1
    
    PUSH {R1}
    BL  _scanf		     @ _scanf for second number here 
    MOV R2, R0          @ obtained second number in R2
    POP {R1}
 
    PUSH {R1}
    PUSH {R2}

    BL count_partitions
    
    POP {R2}
    POP {R1}
    
    @ code to enter calculated result in R1, N in R2, M in R3
    
    MOV R3, R2
    MOV R2, R1    
    MOV R1, R0
     
    BL _print_result
      
    POP {R5}
    POP {R4}
    POP {R3}
    B main

count_partitions:
	PUSH {LR}
	
	CMP R1, #0
	MOVEQ R0, #1
	POPEQ {PC}
	MOVLT R0, #0
	POPLT {PC}
	
	CMP R2, #0
	MOVEQ R0, #0
	POPEQ {PC}
	
	PUSH {R1}
	SUB R1, R1, R2
	BL count_partitions
	POP {R1}
	PUSH {R2}
	PUSH {R0}
	SUB R2, R2, #1
	BL count_partitions
	POP {R3}
	ADD R0, R0, R3
	POP {R2}
	POP {PC}
   
_scanf:
    PUSH {LR}                @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                 @ return

_print_result:
	PUSH {LR}
        LDR  R0, =result_str
        BL printf
	POP {PC}
        

.data
format_str:     .asciz      "%d"
format_str1:    .asciz      "%d"
exit_str:       .ascii      "Terminating program.\n"
result_str:     .asciz      "There are %d partitions of %d using integers up to %d.\n"

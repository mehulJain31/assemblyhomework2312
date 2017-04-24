.global main
.func main

main:
  
  
   BL _scanf            @take the first input
   MOV R1, R0           @first variable stored in R1
  
   PUSH {R1}           @ because R1 has initialized again in scanf
   BL _scanf           @call scanf for second input
   MOV R2, R0          @second variable stored in R2
   POP {R1}
   
   
   BL count_partitions @branch to the function  
   
    MOV R3,R2    @ for printing the variables
    MOV R2,R1
    MOV R1,R0
    
    BL _printf
    
    B main                          @run the code again, as instructed in the homework
   
   
   count_partitions:
      PUSH {LR}
      
      CMP R1,#0
      MOVEQ R0,#1    @if n=0, return 1
      
      
      MOVLT R0,#0  @ if n<0 return 0
      
      
      CMP R2,#0      @ compare m with 0
      MOVEQ R0,#0
      
      
      PUSH {R1}
      SUB R1,R1,R2
      BL count_partitions
      MOV R3,R0
      POP {R1}
      
      PUSH {R2}
      SUB R2,R2,#1
      BL count_partitions
      ADD R0,R0,R3
      POP {R2}
      
      POP {PC}
      
   
  _printf:
	PUSH {LR}
        LDR  R0, =printf_str
        BL printf
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



.data
    format_str:	   .asciz	"%d"
    printf_str:    .asciz      "There are %d partitions of %d using integers up to %d\n"
    

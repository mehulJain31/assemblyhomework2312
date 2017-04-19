.global main
.func main

main:
   BL _scanf           @take the first input
   MOV R1,R0           @first variable stored in R1
   BL _scanf           @call scanf for second input
   MOV R2,R0           @second variable stored in R2
   BL _countpartitions @branch to the function   
   
   
  BL _counterpartitions:
   
  
  _scanf:
    MOV R4, LR                           @ store LR since printf call overwrites
    SUB SP, SP, #4                       @ make room on stack
    LDR R0, =format_str                  @ R0 contains address of format string 
    MOV R1, SP                           @ move SP to R1 to store entry on stack 
    BL scanf                             @ call scanf
    LDR R0, [SP]                         @ load value at SP into R0
    ADD SP, SP, #4                       @ restore the stack pointer
    MOV PC, R4                           @ return


.data
    format_str:	   .asciz	"%d"
    

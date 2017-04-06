.global main
.func main

main:
   BL _scanf      @take the first input
   MOV R9,R0      @first variable in R9
   BL _getchar    @take the symbol input
   MOV R10,R0     @ symbol in R10
   BL _scanf      @call scanf for second input
   MOV R11,R0     @second variable in R11
   BL _compare    @compare function for determining what function to use
   BL main        @loop until the user wants
   
   
  
 
_scanf:
    PUSH {LR}                          @ store LR since printf call overwrites
    SUB SP, SP, #4                       @ make room on stack
    LDR R0, =format_str                  @ R0 contains address of format string 
    MOV R1, SP                           @ move SP to R1 to store entry on stack 
    BL scanf                             @ call scanf
    LDR R0, [SP]                         @ load value at SP into R0
    ADD SP, SP, #4                       @ restore the stack pointer
    POP {PC}                           @ return
   
  _getchar:
    MOV R7, #3              @ write syscall, 3
    MOV R0, #0              @ input stream from monitor, 0
    MOV R2, #1              @ read a single character
    LDR R1, =read_char      @ store the character in data memory
    SWI 0                   @ execute the system call
    LDR R0, [R1]            @ move the character to the return register
    AND R0, #0xFF           @ mask out all but the lowest 8 bits
    MOV PC, LR              @ return
    
    _compare:
    CMP R10, #'+'            @ compare against the constant char '@'
    BEQ _add                 @ branch to equal handler
    @ BNE _          @ branch to not equal handle
    
    _add:
     add R0,R9,R11   @ add the variable and store in R0
     MOV R1,R0      @save the answer in a procedure return argument
     LDR R1,=printf_str
     BL  printf      @print the result
     
     
    
    
    
    .data
    format_str:	.asciz	"%d"
    read_char:	.ascii	" "
    printf_str:	.asciz	"%d\n"

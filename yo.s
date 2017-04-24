.global main
.func main


main:
   BL _scanf      @take the first input
   MOV R9,R0      @first variable stored in R9
   BL _getchar    @take the symbol input
   MOV R10,R0     @ symbol stored in R10
   BL _scanf      @call scanf for second input
   MOV R11,R0     @second variable stored in R11
   BL _compare    @compare function for determining what manipulation to use
   MOV R1,R0      @move the temporary R0 to R1 for printing the result
   BL _print      @print the answer
   BL main        @loop until the user wants to enter the variables
   
   
_scanf:
    MOV R4, LR                           @ store LR since printf call overwrites
    SUB SP, SP, #4                       @ make room on stack
    LDR R0, =format_str                  @ R0 contains address of format string 
    MOV R1, SP                           @ move SP to R1 to store entry on stack 
    BL scanf                             @ call scanf
    LDR R0, [SP]                         @ load value at SP into R0
    ADD SP, SP, #4                       @ restore the stack pointer
    MOV PC, R4                           @ return
   
_getchar:
    MOV R7, #3              @ write syscall, 3
    MOV R0, #0              @ input stream from monitor, 0
    MOV R2, #1              @ read a single character
    LDR R1, =read_symbol    @ store the character in data memory
    SWI 0                   @ execute the system call
    LDR R0, [R1]            @ move the character to the return register
    AND R0, #0xFF           @ mask out all but the lowest 8 bits
    MOV PC, LR              @ return
    
_compare:
    PUSH {LR}            @stack manipulation
    
    CMP R10,#'+'         @compare for +
    BEQ _addition        @ call the function
       
    CMP R10,#'-'         @compare for -
    BEQ _subtract
       
    CMP R10,#'*'         @compare for *
    BEQ _product
       
    CMP R10,#'M'         @compare for M (Maximum)
    BEQ _maximum
       
    POP {PC}
       
_addition:   
      PUSH {LR}          @open stack
      ADD R0,R9,R11      @ Add them
      POP {PC}
      
_subtract:
      PUSH {LR}         @open stack
      SUB R0,R9,R11     @Subtract them
      POP {PC}
      
_product:
      PUSH {LR}        @open stack
      MUL R0,R9,R11    @ multiply them
      POP {PC}
      
_maximum:
      PUSH {LR}      @open stack
      CMP R9,R11     @compare the user values
      MOVGT R11,R9   @ assign R11, R9 if R9>R11
      MOV R0,R11     @ Move the greater number to R0  for printing the result
      POP {PC}
          
 _print:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_str     @ R0 contains formatted string address
    MOV R1, R1              @ R1 contains printf argument 1 (redundant line)
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return
      
 .data
    format_str:	   .asciz	"%d"
    read_symbol:	   .ascii	" "
    printf_str:      .asciz	"%d\n"

.global main
.func main
   
main:
    BL  _prompt             @ branch to prompt procedure with return
    BL  _scanf              @ branch to scanf procedure with return for first variable
    MOV R1, R0              @ move return value R0 to argument register R1
    BL _printf                
    
    BL  _prompt             @ branch to prompt procedure with return
    BL _scanf               @ branch to scanf for another variable
    MOV R1,R0               @ move return value R0 to argument register R2
    BL _printf
   
@no exit needed as per requirements

_prompt:
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #31             @ print string length
    LDR R1, =prompt_str     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return
       
@no need for printf

    
_scanf:
    PUSH {LR}               @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                @ return
    

       
_printf:
   _printf:
    MOV R4, LR              @ store LR since printf call overwrites
    LDR R0, =printf_str     @ R0 contains formatted string address
    MOV R1, R1              @ R1 contains printf argument (redundant line)
    BL printf               @ call printf
    MOV PC, R4              @ return    

.data
format_str:     .asciz      "%d"
prompt_str:     .asciz      "Type the first number and press enter: "
symbol_input:   .asciz      " Enter the symbol:"
prompt_str1:    .asciz      "Type the second number and press enter: "
printf_str:     .asciz      "The answer is : %d\n"

.global main
.func main
   
main:
    BL  _prompt1             @ branch to prompt procedure with return
    BL  _scanf1              @ branch to scanf procedure with return
    MOV R1, R0              @ move return value R0 to argument register R1
    BL  _printf1             @ branch to print procedure with return
 
    BL  _prompt2             @ branch to prompt procedure with return
    BL  _scanf2              @ branch to scanf procedure with return
    MOV R2, R0              @ move return value R0 to argument register R1
    BL  _printf2             @ branch print procedure with return
    
   
 
 
    B   _exit               @ branch to exit procedure with no return
   
_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R4, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall

_prompt1:
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R4, #11            @ print string length
    LDR R1, =prompt_str     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return
       
_printf1:
    MOV R5, LR              @ store LR since printf call overwrites
    LDR R0, =printf_str     @ R0 contains formatted string address
    MOV R1, R1              @ R1 contains printf argument (redundant line)
    BL printf               @ call printf
    MOV PC, R5              @ return
    
_scanf1:
    PUSH {LR}                @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                 @ return
    
 _prompt2:
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R4, #11             @ print string length
    LDR R2, =prompt_str2     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return
       
_printf2:
    MOV R5, LR              @ store LR since printf call overwrites
    LDR R0, =printf_str     @ R0 contains formatted string address
    MOV R2, R2              @ R1 contains printf argument (redundant line)
    BL printf               @ call printf
    MOV PC, R5              @ return
    
_scanf2:
    PUSH {LR}                @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R2, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                 @ return
    
    


.data
format_str:     .asciz      "%d"
prompt_str:     .asciz      "1st number: "
prompt_str2:     .asciz      "2nd number: "
printf_str:     .asciz      "The number was: %d\n"
exit_str:       .ascii      "Terminating program.\n"
read_char:      .ascii      " "
prompt_str3:     .ascii      "Enter the + character: "
equal_str:      .asciz       "CORRECT \n"
nequal_str:     .asciz      "INCORRECT: %c \n"

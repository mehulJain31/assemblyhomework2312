.global main
.func main
   
main:
    BL  _prompt1             @ branch to prompt procedure with return
    BL  _scanf1              @ branch to scanf procedure with return
    MOV R1, R0              @ move return value R0 to argument register R1
    BL  _printf1             @ branch to print procedure with return
 
    BL  _prompt2             @ branch to prompt procedure with return
    BL  _scanf2              @ branch to scanf procedure with return
    MOV R1, R0              @ move return value R0 to argument register R1
    BL  _printf2             @ branch to print procedure with return
    
    BL  _prompt3             @ branch to printf procedure with return
    BL  _getchar            @ branch to scanf procedure with return
    MOV R1, R0              @ move return value R0 to argument register R1
    BL  _compare            @ check the scanf input
 
 
    B   _exit               @ branch to exit procedure with no return
   
_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall

_prompt1:
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #31             @ print string length
    LDR R1, =prompt_str     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return
       
_printf1:
    MOV R4, LR              @ store LR since printf call overwrites
    LDR R0, =printf_str     @ R0 contains formatted string address
    MOV R1, R1              @ R1 contains printf argument (redundant line)
    BL printf               @ call printf
    MOV PC, R4              @ return
    
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
    MOV R2, #31             @ print string length
    LDR R1, =prompt_str2     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return
       
_printf2:
    MOV R4, LR              @ store LR since printf call overwrites
    LDR R0, =printf_str     @ R0 contains formatted string address
    MOV R1, R1              @ R1 contains printf argument (redundant line)
    BL printf               @ call printf
    MOV PC, R4              @ return
    
_scanf2:
    PUSH {LR}                @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                 @ return
    
    
_prompt3:
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #23             @ print string length
    LDR R1, =prompt_str3     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return
   
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
    CMP R1, #'+'            @ compare against the constant char '+'
    BEQ _correct            @ branch to equal handler
    BNE _incorrect          @ branch to not equal handler
 
_correct:
    MOV R5, LR              @ store LR since printf call overwrites
    LDR R0, =equal_str      @ R0 contains formatted string address
    BL printf               @ call printf
    MOV PC, R5              @ return
 
_incorrect:
    MOV R5, LR              @ store LR since printf call overwrites
    LDR R0, =nequal_str     @ R0 contains formatted string address
    BL printf               @ call printf
    MOV PC, R5              @ return


.data
format_str:     .asciz      "%d"
prompt_str:     .asciz      "Type a number and press enter: "
prompt_str2:     .asciz      "Type a 2nd number and press enter: "
printf_str:     .asciz      "The number entered was: %d\n"
exit_str:       .ascii      "Terminating program.\n"
read_char:      .ascii      " "
prompt_str3:     .ascii      "Enter the + character: "
equal_str:      .asciz      "CORRECT \n"
nequal_str:     .asciz      "INCORRECT: %c \n"

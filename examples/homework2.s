.global main
.func main
   
main:
    BL  _prompt1             @ branch to prompt procedure with return
    BL  _scanf1              @ branch to scanf procedure with return for first variable
    MOV R1, R0              @ move return value R0 to argument register R1
                  
    
    BL  _prompt2             @ branch to prompt procedure with return
    BL _scanf2               @ branch to scanf for another variable
    MOV R1,R0               @ move return value R0 to argument register R2

    
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
    LDR R1, =prompt_str1     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return
       
_prompt2:
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #31             @ print string length
    LDR R1, =prompt_str2     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return


    
_scanf1:
    PUSH {LR}               @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                @ return
    
    
 _scanf2:
    PUSH {LR}               @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                @ return

       
  

.data
format_str:     .asciz      "%d"
prompt_str1:     .asciz      "  "
prompt_str2:    .asciz       "  "
printf_str:     .asciz       "\nThe number entered was: %d\n"
exit_str:     .ascii         "Terminating Program\n"

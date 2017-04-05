.global main
.func main
   
main:
    BL  _prompt1             @ branch to prompt procedure with return
    BL  _scanf1              @ branch to scanf procedure with return for first variable
    MOV R1, R0              @ move return value R0 to argument register R1
                  
    
    BL  _prompt             @ branch to printf procedure with return
    BL  _getchar            @ branch to scanf procedure with return
    MOV R3, R0              @ move return value R0 to argument register R1
    BL  _compare1            @ check the scanf input
    
    BL  _prompt2             @ branch to prompt procedure with return
    BL _scanf2               @ branch to scanf for another variable
    MOV R2,R0               @ move return value R0 to argument register R2

    
    B   _exit               @ branch to exit procedure with no return
   
_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall


_prompt1:
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R4, #31             @ print string length
    LDR R1, =prompt_str1     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return

_prompt:
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R4, #23             @ print string length
    LDR R1, =prompt_str     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return
    
 _getchar:
    MOV R7, #3              @ write syscall, 3
    MOV R0, #0              @ input stream from monitor, 0
    MOV R2, #1              @ read a single character
    LDR R3, =read_char      @ store the character in data memory
    SWI 0                   @ execute the system call
    LDR R0, [R3]            @ move the character to the return register
    AND R0, #0xFF           @ mask out all but the lowest 8 bits
    MOV PC, LR              @ return
    
    
  _compare1:
    CMP R3, #'+'            @ compare against the constant char '+'
    BEQ _add                @ branch to addition handler
    BNE _-compare2          @ branch to subtract check handler
    
    _add:
    MOV R5, LR              @ store LR since printf call overwrites
    LDR R0, =equal_str      @ R0 contains formatted string address
    BL printf               @ call printf
    MOV PC, R5              @ return

_-compare2:
    CMP R3, #'-'            @ compare against the constant char '-'
    BEQ _subtract            @ branch to subtract handler
    BNE _*compare3             @ branch to multiply check 
    
 _subtract:
    MOV R5, LR              @ store LR since printf call overwrites
    LDR R0, =equal_str      @ R0 contains formatted string address
    BL printf               @ call printf
    MOV PC, R5              @ return
    
  _-compare3:
    CMP R3, #'*'            @ compare against the constant char '*'
    BEQ _multiply            @ branch to multiply handler
    BNE _*compare4            @ branch to multiply check 
    
 _multiply:
    MOV R5, LR              @ store LR since printf call overwrites
    LDR R0, =equal_str      @ R0 contains formatted string address
    BL printf               @ call printf
    MOV PC, R5              @ return
    
_-compare4:
    CMP R3, #'M'            @ compare against the constant char 'M'
    BEQ _maximum            @ branch to maximum handler
    BNE _incorrect          @ branch to not equal handler
    
_incorrect:
    MOV R5, LR              @ store LR since printf call overwrites
    LDR R0, =nequal_str     @ R0 contains formatted string address
    BL printf               @ call printf
    MOV PC, R5              @ return
    


_prompt2:
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R4, #31             @ print string length
    LDR R2, =prompt_str2     @ string at label prompt_str:
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
read_char:      .ascii      " "
prompt_str:     .ascii      "Enter the +/-/*/M character: "
equal_str:      .asciz      "CORRECT \n"
nequal_str:     .asciz      "INCORRECT: %c \n"ompt_str2:    .asciz       "  "



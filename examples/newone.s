.text
.global main
.extern printf
.extern scanf

main:
  
  push  {ip,lr}
  ldr R0, =prompt   @print the prompt to take the first input
  bl printf
  
  ldr R0,=format   @take input by %d
  ldr R1,=num1      @ take input of the first variable in R1
  bl scanf         @ take the input
  
  
  ldr R1,=num1
  ldr R1,[R1]
  ldr R0,=output   @print the input taken
  bl printf        @ print it
  
  ldr R0,=prompt
  bl printf
  
  ldr R0,=format
  ldr R2,=num2
  bl scanf
  
  ldr R2,=num2
  ldr R2,[R2]
  ldr R0,=output
  bl printf
  
  
  
  pop  {ip,pc}
  
  
  
  .data
  prompt : .asciz ">"
  format : .asciz  "%d"
  num1 : .int 0
  num2: .int 0
  output : .asciz "Your input: %d\n"
  

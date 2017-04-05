.text
.global main
.extern printf
.extern scanf

main:
  
  push  {ip,lr}
  ldr R0, =prompt   @print the prompt to take the first input
  bl printf
  
  ldr R0,=format   @take input by %d
  ldr R1,=num      @ take input of the first variable in R1
  bl scanf         @ take the input
  
  ldr R1,=num
  ldr R1,[R1]
  ldr R0,=output   @print the input taken
  bl printf        @ print it
  
  
  pop  {ip,pc}
  
  
  
  .data
  prompt : .asciz ">"
  format : "%d"
  num : .int 0
  output : .asciz "Your input: %d\n"
  

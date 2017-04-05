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
  
  


  ldr R0,=prompt
  bl printf
  
  ldr R0,=format
  ldr R2,=num2
  bl scanf
  
  pop  {ip,pc}
  
  
  
  .data
  prompt : .asciz ">"
  format : .asciz  "%d"
  num1 : .int 0
  num2: .int 0
  

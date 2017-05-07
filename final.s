.global main
.func main

main:
	MOV R7,#0
	MOV R1,#0
	MOV R2,#255
writeloop:
	CMP R1,#10	
	BEQ doneloop	
	PUSH {R1}
	PUSH {R2}
	BL _scanf	@ Take user input
	POP {R2}
	POP {R1}
	LDR R4, =a
	LSL R5,R1,#2
	ADD R5,R5,R4
	STR R0, [R5]
	ADD R1,R1,#1
	B writeloop

doneloop:	
	PUSH {R2}
	MOV  R0,#0
	
readloop:
	CMP R0,#10
	BEQ readdone
	LDR R1,=a
	LSL R2,R0,#2
	ADD R2,R1,R2
	LDR R1, [R2]
	PUSH {R0}
	PUSH {R1}
	PUSH {R2}
	MOV R2,R1
	MOV R1,R0
	BL _printf
	POP {R2}
	POP {R1}
	POP {R0}
	ADD R0,R0,#1
	B readloop

readdone:
	POP {R2}
	BL _printf1
	BL _scanf1

MOV R0,#0
MOV R9,#0
readloop1:
	CMP R0,#10
	BEQ _exit
	LDR R1,=a
	LSL R2,R0,#2
	ADD R2,R1,R2
	LDR R1, [R2]
	PUSH {R0}
	PUSH {R1}
	PUSH {R2}
	MOV R2,R1
	MOV R1,R0
	CMP R8,R2
	BEQ _printf
	ADD R0,R0,#1
	B readloop1
	POP {R2}
	POP {R1}
	POP {R0}
	
	


notfound:
	PUSH {LR}
	LDR R0,=not_str
	BL printf
	POP {PC}
	
readdone1:
	POP {R2}
	BL _exit
	
_printf:
	PUSH {LR}
	LDR R0,=printf_str
	BL printf
	POP {PC}

	
_printf1:
	PUSH {LR}
	LDR R0,=printf_str1
	BL printf
	POP {PC}
	

_scanf:
	MOV R4,LR
	SUB SP,SP,#4
	LDR R0,=format_str
	MOV R1,SP
	BL scanf
	LDR R0, [SP]
	ADD SP,SP,#4
	MOV PC,R4


_exit:
	@CMP R9,#0
	@BEQ notfound
	MOV  R7,#4
	MOV R0,#1
	MOV R2,#21
	SWI 0
	MOV R7,#1
	SWI 0

_scanf1:
	MOV R4,LR
	SUB SP,SP,#4
	LDR R0,=format_str1
	MOV R1,SP
	BL scanf
	LDR R0, [SP]
	MOV R8,R0
	ADD SP,SP,#4
	MOV PC,R4


.data
.balign 4
a:		.skip	40
printf_str:	.asciz	"a[%d] = %d\n"
printf_str1:	.asciz   "ENTER A SEARCH VALUE:"
format_str1:	.asciz	"%d"
exit_str:	.asciz   "Terminating Program"
format_str:	.asciz	"%d"
not_str:        .asciz  "That value does not exist in the array\n"

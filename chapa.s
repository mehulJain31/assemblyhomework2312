.global main
	.func main

main:
	MOV R7,#0
	MOV R1,#0
	MOV R2,#255
LOOP:
	CMP R1,#10	@if R1 = 10 exit
	BEQ done	@if 10 exit
	PUSH {R1}
	PUSH {R2}
	BL _scanf	@GET INPUT
	POP {R2}
	POP {R1}
	CMP R8,R0	@if R2 < input
	MOVLT R8,R0
	CMP R2,R0	@if R3 > input 
	MOVGT R2,R0
	ADD R7,R7,R0
	LDR R4, =a
	LSL R5,R1,#2
	ADD R5,R5,R4
	STR R0, [R5]
	ADD R1,R1,#1
	B LOOP

done:	PUSH {R2}
	MOV  R0,#0
read:
	CMP R0,#10
	BEQ rdone
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
	B read



rdone:
	POP {R2}
	MOV R1,R2
	BL _pmin
	MOV R1,R8
	BL _pmax
	MOV R1,R7
	BL _psum
	B _exit



_exit:
	MOV  R7,#4
	MOV R0,#1
	MOV R2,#21
	SWI 0
	MOV R7,#1
	SWI 0

_printf:
	PUSH {LR}
	LDR R0,=print_str
	BL printf
	POP {PC}
_pmin:
	PUSH {LR}
	LDR R0,=print_min
	BL printf
	POP {PC}
_pmax:
	PUSH {LR}
	LDR R0, =print_max
	BL printf
	POP {PC}
_psum:
	PUSH {LR}
	LDR R0,=print_sum
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

.data
.balign 4
a:		.skip	40
print_str:	.asciz	"a[%d] = %d\n"
exit_str:	.asciz	"Exit"
format_str:	.asciz	"%d"
print_min:	.asciz  "min = %d\n"
print_max:	.asciz	"max = %d\n"
print_sum:	.asciz 	"sum = %d\n"

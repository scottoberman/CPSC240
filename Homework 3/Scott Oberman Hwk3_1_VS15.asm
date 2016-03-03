; Scott Oberman
; 2/18/16
; Homework #3: Performs arithemetic operations using the EAX, EBX, ECX, and EDX
;			   registers: A = ((A + B) - (C + D)) + C.
;			   The final answer will be in the eax register.

INCLUDE Irvine32.inc
.data
	tempVal1 DWORD 0
	tempVal2 DWORD 0
	finalVal DWORD 0
.code
main PROC
	; Assign initial values
	mov	eax, 4000h
	mov ebx, 1000h
	mov ecx, 3000h
	mov edx, 1500h

	; tempVal1 = (A + B)
	add tempVal1, eax
	add tempVal1, ebx

	; tempVal2 = (C + D)
	add tempVal2, ecx
	add tempVal2, edx

	; tempVal1 = (A + B) - (C + D)
	mov edx, tempVal1
	sub edx, tempVal2
	mov tempVal2, edx

	; A = ((A + B) - (C + D)) + C
	mov eax, tempVal2
	add eax, ecx

	mov finalVal, eax

	call	DumpRegs		; display the registers
	call	WaitMsg
	exit
main ENDP
END main



### OUTPUT###

  EAX=00003B00  EBX=00001000  ECX=00003000  EDX=00000B00
  ESI=00F41055  EDI=00F41055  EBP=0018FA24  ESP=0018FA14
  EIP=00F4356F  EFL=00000206  CF=0  SF=0  ZF=0  OF=0  AF=0  PF=1

Press any key to continue...
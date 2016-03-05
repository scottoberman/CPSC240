; Scott Oberman
; Due 3/17/2016
; Homework #4: Reverses a double word array by using direct addressing
;			   and the stack

INCLUDE Irvine32.inc
.data
	dwarray DWORD 3, 5, 7, 9, 13, 15, 17, 19
.code
main PROC

	mov eax, 0
	mov ecx, LENGTHOF dwarray
	
	; Push the array to the stack
	readarrayloop:

		mov ebx, dwarray + [eax]

		push ebx

		add eax, SIZE DWORD


		loop readarrayloop


	mov eax, 0

	mov ecx, LENGTHOF dwarray

	; Read the array back from the stack, revsersing the original array
	writearrayloop:
		
		pop ebx

		mov dwarray + [eax], ebx

		add eax, SIZE DWORD

		loop writearrayloop

	; Output the reversed array
    mov esi, OFFSET dwarray
 	mov ecx, LENGTHOF dwarray
	mov ebx, TYPE dwarray
    call DumpMem
	call	WaitMsg
	exit
main ENDP
END main



;		OUTPUT	
;
;	Dump of offset 00016000
;	-------------------------------
;	00000013  00000011  0000000F  0000000D  00000009  00000007  00000005  00000003  
;	Press any key to continue...
; Scott Oberman
; Due 3/17/2016
; Homework #4: Reverses a double word array by using indirect addressing
;			   stirig pointers

INCLUDE Irvine32.inc
.data
	dwarray DWORD 3, 5, 7, 9, 13, 15, 17, 19
.code
main PROC

	mov esi, OFFSET dwarray
	mov edi, OFFSET (dwarray + SIZEOF dwarray - TYPE dwarray)

	mov ecx, LENGTHOF dwarray

	arrayLoop:
		
		mov eax, [esi]
		mov ebx, [edi]
		mov [edi], eax
		mov [esi], ebx


		add esi, 4
		sub edi, 4
		cmp esi, edi

		jb arrayLoop


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
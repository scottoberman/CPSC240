; Scott Oberman
; Due 4/7/2016
; Homework #5: Sorts an array by using an insertion sort. The sorted array is
;			   then output.
; Compiled with Visual Studio 2015

TITLE Homework 5 - Scott Oberman - VS15

INCLUDE Irvine32.inc

.data

	array BYTE 20, 10, 60, 5, 120, 90, 100, 7, 25, 12

.code

main PROC

;	Esi will point to the base index of the array
	mov esi, OFFSET array

;	Eax will act as the the the leading index of examination
	mov eax, esi

;	Ebx will act as the secondary index of examination

;	Edx will act as the tertiary index of examination (one index below the
;	secondary index of examination)

;	Edi will act as a temp variable (sort of like the stack but faster probably)

	mov ecx, LENGTHOF array
	dec ecx

	insertionSortOuter:

		mov edx, eax
		inc eax
		mov ebx, eax

		insertionSortInner:

			; Check if the address is equal to or before the base address of the array
			cmp ebx, esi
			jbe afterInsertionSortInner

			; Check to see if the value being examined needs to be swapped with the other examined value
			; Place the value of eax into edi so the ah and al registers may be used for comparisons.
			mov edi, eax
			mov al, BYTE PTR [edx]
			mov ah, BYTE PTR [ebx]
			cmp al, ah
			jbe afterInsertionSortInner

			; Exchange the values of the indices if the values are out of order
			mov [edx], ah
			mov [ebx], al
			mov eax, edi

			; Move down one index of the array
			dec ebx
			dec edx

			jmp insertionSortInner

		afterInsertionSortInner:

		mov eax, edi

		loop insertionSortOuter

	; Output the sorted array
    mov esi, OFFSET array
 	mov ecx, LENGTHOF array
	mov ebx, TYPE array
    call DumpMem
	call	WaitMsg
	exit

main ENDP
END main



########## OUTPUT ##########

Dump of offset 01226000
-------------------------------
05 07 0A 0C 14 19 3C 5A 64 78
Press any key to continue...
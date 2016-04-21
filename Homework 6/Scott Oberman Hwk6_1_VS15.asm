; Scott Oberman
; Due 4/21/2016
; Homework #6: Create a procedure that generates a hash number that will
;			   result in the fewest number of collisions. The hash values
;			   are simply calculated; the strings are not moved to an address
;			   based on their hash value. In an attempt to reduce the number
;			   of collisions, this hash function adds four to the ascii value
;			   letters that are lower case and greater than 'l'.
;
; Compiled with Visual Studio 2015

TITLE Homework 6 - Scott Oberman - VS15

INCLUDE Irvine32.inc

.data

	; The strings for which the hash values will be generated
	str1	BYTE	"Herman Smith",			0
	str2	BYTE	"Louie Joines",			0
	str3	BYTE	"Robert Sherman",		0
	str4	BYTE	"Barbara Goldenstein",	0
	str5	BYTE	"Johnny Unitas",		0
	str6	BYTE	"Tyler Abrams",			0
	str7	BYTE	"April Perkins",		0
	str8	BYTE	"William Jones",		0
	str9	BYTE	"Steve Schockley",		0
	str10	BYTE	"Steve Williams",		0

	; Number of strings/arrays to be hashed
	NUM_OF_ARRAYS	TEXTEQU %10


	; The number of hash numbers available. Can easily be adjusted to reduce the
	; number of collisions.
	TABLE_SIZE		TEXTEQU %11

	; Array which holds the base index of each of the arrays to be hashed
	arrayOfStringBaseIndices DWORD NUM_OF_ARRAYS (OFFSET str1), (OFFSET str2),
												 (OFFSET str3), (OFFSET str4),
												 (OFFSET str5), (OFFSET str6),
												 (OFFSET str7), (OFFSET str8),
												 (OFFSET str9), (OFFSET str10)

	; Array which holds the lengths of each array to be hashed
	arrayOfStringLengths	 BYTE NUM_OF_ARRAYS (LENGTHOF str1), (LENGTHOF str2),
												(LENGTHOF str3), (LENGTHOF str4),
												(LENGTHOF str5), (LENGTHOF str6),
												(LENGTHOF str7), (LENGTHOF str8),
												(LENGTHOF str9), (LENGTHOF str10)

	; Array which will hold each array's respective hash value
	arrayOfHashes DWORD NUM_OF_ARRAYS  DUP(0)

	

.code

;*****************************************************************************
; Procedure	 : Hash
;
; Description: Generates a hash value based upon the sum of all bytes in the
;			   array. In an attempt to reduce the number of collisions,
;			   lower case letters greater than 'l' will have 4 added to their
;			   hash value.
;
; Passed In  : ECX: Length of the array
;			   ESI: Base index of array
;			   EDI: Table size from which hash will be generated
;
; Othr Rgtrs : EAX: Holds running sum of hash function
;			   EBX: Holds ascii value of current letter
;
; Returns	 : EDX: Hash value
;*****************************************************************************

	Hash PROC

		push esi
		push eax
		push ebx

		xor eax, eax
		xor edx, edx
		
		sumArrayLoop:

			movzx ebx, BYTE PTR [esi]

			cmp BYTE PTR [esi], 108

			; If the current character is lower case and greater than 'l',
			; add four to its hash value.
			jg notLowerCaseGreaterThanL

			add ebx, 4

			notLowerCaseGreaterThanL:
			add eax, ebx

			inc esi

			loop sumArrayLoop

		DIV edi

		pop ebx
		pop eax
		pop esi


		ret

	Hash ENDP



	main PROC

		; Prepare to find the hash values for the ten strings
		mov ecx, NUM_OF_ARRAYS

		; Put the hash table size into the edi register for use in the hash
		; function
		mov edi, TABLE_SIZE

		; Generate the hash value for each string
		GetHashesLoop:

			; Move the base address of the index marked in ECX into ESI for
			; use in the has function.
			; We are going starting from the last string and moving backwards.
			mov esi, [arrayOfStringBaseIndices + ecx * TYPE ArrayOfStringBaseIndices - TYPE arrayOfStringBaseIndices]

			; Save the ecx register
			push ecx

			mov edx, ecx

			; Move the size of the array marked by ECX into ECX
			movsx ecx, arrayOfStringLengths[edx - 1]

			call Hash

			pop ecx

			

			; Move the hash value into the array marked by ECX
			mov arrayOfHashes[ecx * TYPE arrayOfHashes - TYPE arrayOfHashes], edx

			xor edx, edx

			loop GetHashesLoop
		

		; Output the arrayOfHashes
		mov esi, OFFSET arrayOfHashes
 		mov ecx, LENGTHOF arrayOfHashes
		mov ebx, TYPE arrayOfHashes
		call	DumpMem
		call	WaitMsg


		exit

	main ENDP
	END main

	
Dump of offset 00366A65
-------------------------------
00000009  00000002  00000000  00000001  00000009  00000002  00000006  00000004  00000003  0000000A
Press any key to continue...

With this hash algorithm, there are two collisions with 9 and two collisions with 2 for a total
of four collisions which is an improvement over the nine collisions of the other algorithm.
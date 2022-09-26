
INCLUDE Irvine32.inc

.data
CaseTable BYTE '1'
	DWORD Process_1
EntrySize = ($-CaseTable)
	BYTE '2'
	DWORD Process_2
	BYTE '3'
	DWORD Process_3
	BYTE '4'
	DWORD Process_4
	BYTE '5'
	DWORD Process_5
NumberofEntries = ($-CaseTable) / EntrySize

msg1 BYTE "1. x AND y", 0
msg2 BYTE "2. x OR y", 0
msg3 BYTE "3. NOT x", 0
msg4 BYTE "4. X XOR y", 0
msg5 BYTE "5. Exit program", 0
msg6 BYTE "Choose Calculation Mode : ", 0
msg7 BYTE "Do you want to change the mode(Y/N)? : ", 0
msg8 BYTE "Bye! ", 0

msgx BYTE "Enter x : ", 0
msgy BYTE "Enter y : ", 0

msgr1 BYTE "Result of x AND y : ", 0
msgr2 BYTE "Result of x OR y : ", 0
msgr3 BYTE "Result of NOT x : ", 0
msgr4 BYTE "Result of X XOR y : ", 0

x DWORD ?
y DWORD ?
buffer BYTE 100 DUP(0)
buffercount DWORD ?

.code
main PROC



l0:
call Menu_Print
reinput:
mov edx, OFFSET msg6
call WriteString
call ReadInt

add eax, 48					;---------- '1' == 49 ---------------
mov ebx, OFFSET CaseTable
mov ecx, NumberOfEntries
l1:
	cmp al, [ebx]
	jne l2
	call NEAR PTR [ebx+1]
	call Crlf
	jmp l3
l2:
	add ebx, EntrySize
	loop l1
jmp reinput

l3:
	mov edx, OFFSET msg7
	call WriteString
	mov edx, OFFSET buffer
	mov ecx, SIZEOF buffer
	push eax
	call ReadString
	mov buffercount, eax
	pop eax
	call Crlf
	cmp buffercount, 1
	jne l3
	cmp buffer[0], 'N'
	je l1
	cmp buffer[0], 'Y'
	je l0
	jmp l3

main ENDP

Menu_Print PROC
pushad
mov edx, OFFSET msg1
call WriteString
call Crlf
mov edx, OFFSET msg2
call WriteSTring
call Crlf
mov edx, offset msg3
call WriteString
call Crlf
mov edx, OFFSET msg4
call WriteString
call Crlf
mov edx, OFFSET msg5
call WriteString
call Crlf
call Crlf
popad
ret
Menu_Print ENDP

Process_1 PROC
	pushad
	mov edx, OFFSET msgx
	call WriteString
	call ReadHex ; X input
	mov x, eax
	mov edx, OFFSET msgy
	call WriteString
	call ReadHex ; Y input

	AND eax, x
	mov y, eax

	mov edx, OFFSET msgr1
	call WriteString
	mov eax, y
	call WriteHex
	call Crlf
	popad
	ret
Process_1 ENDP

Process_2 PROC
	pushad
	mov edx, OFFSET msgx
	call WriteString
	call ReadHex ; X input
	mov x, eax
	mov edx, OFFSET msgy
	call WriteString
	call ReadHex ; Y input

	OR eax, x
	mov y, eax

	mov edx, OFFSET msgr2
	call WriteString
	mov eax, y
	call WriteHex
	call Crlf
	popad
	ret
Process_2 ENDP

Process_3 PROC
	pushad
	mov edx, OFFSET msgx
	call WriteString
	call ReadHex ; X input

	NOT eax
	mov y, eax

	mov edx, OFFSET msgr3
	call WriteString
	mov eax, y
	call WriteHex
	call Crlf
	popad
	ret
Process_3 ENDP

Process_4 PROC
	pushad
	mov edx, OFFSET msgx
	call WriteString
	call ReadHex ; X input
	mov x, eax
	mov edx, OFFSET msgy
	call WriteString
	call ReadHex ; Y input

	XOR eax, x
	mov y, eax

	mov edx, OFFSET msgr4
	call WriteString
	mov eax, y
	call WriteHex
	call Crlf
	popad
	ret
Process_4 ENDP

Process_5 PROC
	mov edx, OFFSET msg8
	call WriteString
	exit
	ret
Process_5 ENDP

END main
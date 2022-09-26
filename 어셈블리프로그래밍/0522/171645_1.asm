
INCLUDE irvine32.inc

.data
buffer BYTE 100 DUP(0)
byteCount DWORD ?
Stypebefore BYTE "Type_A_String_To_Reverse: ",0
Stypeafter BYTE "Reversed_String: ",0
Sendp BYTE "Bye!",0

.code
main PROC
top:
call InputString
call ReverseString
jmp top
exit
main ENDP

;--------------------------
UpperLower PROC
; Upper to Lower, Lower to Upper
;--------------------------
pushad
mov ecx, byteCount
mov esi, 0
l3:
	prog:
	mov al, buffer[esi]
	cmp buffer[esi], 0
	je endjp
	cmp buffer[esi], 'A'
	jb next
	cmp buffer[esi], 'Z'
	jbe uptolow
	cmp buffer[esi], 'a'
	jb next
	cmp buffer[esi], 'z'
	jbe lowtoup

	jmp next
	next:
		inc esi
		jmp prog

	uptolow:
		add al,32d
		mov buffer[esi],al
		inc esi
		jmp prog

	lowtoup:
		sub al,32d
		mov buffer[esi],al
		inc esi
		jmp prog

	endjp:

loop l3

popad
ret
UpperLower ENDP

;-------------------
InputString PROC
;if input num > 40 then reinput
;-------------------
pushad
l4_main:
	mov edx, OFFSET Stypebefore
	call WriteString

	mov edx, OFFSET buffer
	mov ecx, SIZEOF buffer
	call ReadString

	cmp eax, 0
	je exitfunc

	jmp noexit

exitfunc:
	mov edx, OFFSET Sendp
	call WriteString
	exit

noexit :
	cmp eax, 40
	jg l4_main

	mov byteCount, eax
	mov edx, OFFSET Stypeafter
	call WriteString
	popad
	ret
InputString ENDP

;-----------------------
ReverseString PROC
; reverse string, up <-> low, print
;-----------------------
mov ecx, byteCount
mov esi, 0

l1:
	movzx eax, buffer[esi]
	push eax
	inc esi
loop l1

mov ecx, byteCount
mov esi, 0

l2:
	pop eax
	mov buffer[esi],al
	inc esi
loop l2

call UpperLower

mov edx, OFFSET buffer
call WriteString
call Crlf
ret
ReverseString ENDP

END main
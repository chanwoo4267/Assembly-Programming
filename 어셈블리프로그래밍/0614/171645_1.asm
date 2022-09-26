
INCLUDE Irvine32.inc
BUFMAX = 41
KEYMAX = 100

.data
sPrompt BYTE "Enter a plain text : ",0
sEncrypt BYTE "Encrypted Text : ", 0
sDecrypt BYTE "Decrypted Text : ",0
sKey BYTE "Enther a key : ",0
sOrigin BYTE "Original Text : ",0
sExit Byte "Bye!", 0

dkey BYTE KEYMAX+1 DUP(0)
buffer BYTE BUFMAX+1 DUP(0)
bufSize DWORD ?
keySize DWORD ?

INTARRAY SDWORD 100 DUP(0)
INTSIZE DWORD ?

.code
main PROC

mainloop:
call GetArray
call GetIntArray
call Encrypt
jmp mainloop

exit
main ENDP

GetArray PROC
pushad
mov edx, OFFSET sPrompt
call WriteString
mov ecx, BUFMAX
mov edx, OFFSET buffer
call ReadString
mov bufSize, eax
cmp eax, 0
je exitfunc

popad
ret
exitfunc:
mov edx, OFFSET sExit
call WriteString
exit
GetArray ENDP

GetIntArray PROC
pushad
mov edx, OFFSET sKey
call WriteString
mov ecx, KEYMAX
mov edx, OFFSET dKey
call ReadString
mov keySize, eax

mov ecx, keySize ; loop counter
mov eax, OFFSET INTARRAY
mov ebx, SDWORD PTR [eax]
mov eax, 0
mov esi, 0
mov edi, 0
mov INTSIZE, 0

l1: 
cmp dKey[esi], ' '
je split
add esi, 1
add eax, 1
loop l1

split:
push esi
push ecx

mov edx, OFFSET dKey
sub esi, eax ; esi == length of split string
add edx, esi ; offset start position

mov ecx, eax
cmp ecx, 0
je finalvalue
jmp after
finalvalue:
add ecx, 1
after:

call ParseInteger32 ; eax : divided integer

mov ebx, OFFSET INTARRAY
mov SDWORD PTR [ebx + edi], eax

add edi, 4
add INTSIZE, 1

pop ecx
pop esi

cmp ecx, 0
je next

mov eax, 0
sub ecx, 1
add esi, 1
jmp l1

next:
popad
call Crlf
ret
GetIntArray ENDP
;--------------------------------------------
Encrypt PROC
pushad
mov edx, OFFSET sOrigin
call WriteString
mov edx, OFFSET buffer
call WriteString
call Crlf
mov edx, OFFSET sEncrypt
call WriteString

mov ecx, bufsize
mov esi, 0 ; buff counter
mov edx, 0 ; if key is above keymax, refresh to 0 counter
mov edi, 0 ; int_array counter
mov eax, OFFSET INTARRAY
mov ebx, 0 ; save int_array's num

r1:
cmp edx, INTSIZE
jae refresh
jmp norefresh
refresh:
	mov edx, 0
	mov edi, 0
norefresh:
	mov ebx, SDWORD PTR [eax + edi]
	add edi, 4
	add edx, 1

	push ecx ; new loop counter
	push eax ; buff character save
	mov eax, 0
	mov al, buffer[esi]
	inc esi

	cmp ebx, 0
	jl nega
	jmp posi

	nega:
		neg ebx ; if ebx < 0, neg
		mov ecx, ebx
		r2:
			rol al, 1
		loop r2
	jmp endr

	posi:
		mov ecx, ebx
		cmp ecx, 0
		jbe endr
		r3:
			ror al, 1
		loop r3

	endr:
	call WriteChar
	pop eax
	pop ecx

loop r1
call Crlf
mov edx, OFFSET sDecrypt
call WriteString
mov edx, OFFSET buffer
call WriteString
call Crlf
call Crlf

popad
ret
Encrypt ENDP

END main
INCLUDE irvine32.inc

.data
buffer BYTE 101 DUP(0)
bufsize DWORD ?
s1 BYTE "Input : ", 0
s2 BYTE "Output : ", 0
ssuc BYTE "YES", 0
sf BYTE "NO", 0

.code
main proc
start:
mov edx, OFFSET s1
call WriteString
mov edx, OFFSET buffer
mov ecx, sizeof buffer
call ReadString
cmp eax, 0
je exitf
jmp noexit
exitf:
exit
noexit:
mov bufsize, eax

mov eax, 0 ; ()
mov ebx, 0 ; {}
mov ecx, 0 ; []
mov edx, 0 ; 
mov esi, 0
mov edi, 1

L1:
	cmp esi, bufsize
	jae success

	cmp buffer[esi], '('
	je parent1in

	cmp buffer[esi], '{'
	je parent2in

	cmp buffer[esi], '['
	je parent3in

	cmp buffer[esi], ')'
	je parent1out

	cmp buffer[esi], '}'
	je parent2out

	cmp buffer[esi], ']'
	je parent3out

	add esi, 1
	jmp L1

parent1in:
	cmp eax, 1
	jae fail	

	cmp edi, 1
	je a1

	cmp edi, 2
	je a2

	cmp edi, 3
	je a3

a1:
	mov eax, 1
	add edi, 1
	add esi, 1
	jmp L1

a2:
	mov eax, 2
	add edi, 1
	add esi, 1
	jmp L1

a3:
	mov eax, 3
	add esi, 1
	jmp L1

parent2in:
	cmp ebx, 1
	jae fail

	cmp edi, 1
	je b1

	cmp edi, 2
	je b2

	cmp edi, 3
	je b3

b1:
	mov ebx, 1
	add edi, 1
	add esi, 1
	jmp L1

b2:
	mov ebx, 2
	add edi, 1
	add esi, 1
	jmp L1

b3:
	mov ebx, 3
	add esi, 1
	jmp L1

parent3in:
	cmp ecx, 1
	jae fail

	cmp edi, 1
	je c1

	cmp edi, 2
	je c2

	cmp edi, 3
	je c3

c1:
	mov ecx, 1
	add edi, 1
	add esi, 1
	jmp L1

c2:
	mov ecx, 2
	add edi, 1
	add esi, 1
	jmp L1

c3:
	mov ecx, 3
	add esi, 1
	jmp L1

parent1out:
	cmp eax, 0
	je fail

	cmp ebx, 0
	je a11

	cmp ebx, eax
	ja fail

	a11:
	cmp ecx, 0
	je a12

	cmp ecx, eax
	ja fail

	a12:
	mov eax, 0
	add esi, 1
	sub edi, 1
	
	jmp L1

parent2out:
	cmp ebx, 0
	je fail

	cmp eax, 0
	je b11

	cmp eax, ebx
	ja fail
	b11:
	cmp ecx, 0
	je b12

	cmp ecx, ebx
	ja fail
	b12:

	mov ebx, 0
	add esi, 1
	sub edi, 1
	
	jmp L1

parent3out:
	cmp ecx, 0
	je fail

	cmp eax, 0
	je c11

	cmp eax, ecx
	ja fail
	c11:
	cmp ebx, 0
	je c12

	cmp ebx, ecx
	ja fail

	c12:

	mov ecx, 0
	add esi, 1
	sub edi, 1
	
	jmp L1




fail:
mov edx, OFFSET sf
call WriteString
call crlf
jmp start

success:
mov edx, OFFSET ssuc
call WriteSTring
call crlf
jmp start

ret
main endp

end main
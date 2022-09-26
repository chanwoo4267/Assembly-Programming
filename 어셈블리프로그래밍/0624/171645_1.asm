INCLUDE irvine32.inc

.data
buffer BYTE 50 DUP(0)
bytecount DWORD ?
s1 BYTE "Input : ", 0
s2 BYTE "Output :", 0

.code
main proc
start:
mov edx, OFFSET s1
call WriteString

mov esi, 0
mov ecx, 50
T1:
	mov buffer[esi], ' '
	add esi, 1
loop T1


mov edx, offset buffer
mov ecx, sizeof buffer
call ReadString
cmp eax, 0
je exitmain
cmp eax, 41
jae start
jmp noexit

exitmain:
	exit

noexit:
mov bytecount, eax
mov buffer[eax], ' '
add eax, 1
mov buffer[eax], ' '

call SplitWord

mov edx, OFFSET s2
call WriteSTring

mov edx, OFFSET buffer
mov buffer[50], ' '
call WriteString
call crlf

jmp start

ret
main endp
;-----------------
SplitWord PROC
pushad
mov eax, 0 ; start point
mov ebx, 0 ; num of letter
mov esi, 0 ; 

go:
cmp esi, bytecount
jae split

cmp buffer[esi], ' '
je split

add esi, 1
jmp go

split:
call Reverse
cmp esi, bytecount
jae endfunc
add esi, 1
mov eax, esi
jmp go

endfunc:
popad
ret
SplitWord ENDP

;------------------
Reverse PROC
pushad
mov ecx, esi
sub ecx, eax
add ecx, 1 ; edx = esi - eax + 1
mov edx, ecx
mov esi, eax ; esi = eax startpoint

mov edi, eax ; startpoint
R1:
	movzx eax, buffer[edi]
	push eax
	inc edi
loop R1

mov ecx, edx
mov edi, esi
R2:
	pop eax
	mov buffer[edi], al
	inc edi
loop R2
popad
ret
Reverse ENDP

end main
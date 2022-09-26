INCLUDE irvine32.inc

.data
INTARRAY SDWORD 100 DUP(0)
INTSIZE DWORD ?
buffer BYTE 100 DUP(0)
bufsize DWORD ?
temp BYTE 100 DUP(0)
tempsize DWORD ?
result DWORD ?

s1 BYTE "Input : ", 0
s2 BYTE "Output : ", 0

.code
main proc
start:

mov edx, OFFSET s1
call WriteString
call getintarray
mov ecx, 0
mov ebx, offset INTARRAY
mov edx, OFFSET s2
call WriteString

R1:
mov edx, 0
mov eax, SDWORD PTR [ebx]
add ecx, 1
cmp ecx, eax
ja enddivide ; divisor == num jump to output
div ecx
cmp edx, 0
je R2
jmp R1 ; remainder exist, add divisor 1 and repeat

R2:
mov edx, 0
mov eax, SDWORD PTR [ebx + 4]
cmp ecx, eax
ja enddivide
div ecx
cmp edx, 0
je R3
jmp R1

R3:
mov result, ecx
jmp R1

enddivide:
mov eax, result
call WriteDec
call crlf

jmp start

ret
main endp

;---------------------------
getintarray PROC
pushad
mov ecx, sizeof buffer
mov edx, OFFSET buffer
call ReadString
mov bufsize, eax

cmp eax, 0
je endprogram
jmp skip
endprogram:
exit
skip:
mov ecx, bufsize
mov eax, OFFSET temp
mov ebx, SDWORD PTR [eax]
mov eax, 0
mov esi, 0
mov edi, 0
mov INTSIZE, 0

L1:
	cmp buffer[esi], ' '
	je split
	add esi, 1
	add eax, 1
loop L1

split:
push esi
push ecx
mov edx, offset buffer
sub esi, eax
add edx, esi
mov ecx, eax
cmp ecx, 0
je finalvalue
jmp after
finalvalue:
add ecx, 1
after:
call parseinteger32
mov ebx, offset INTARRAY
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
jmp L1
next:
popad
ret
getintarray ENDP
	

end main
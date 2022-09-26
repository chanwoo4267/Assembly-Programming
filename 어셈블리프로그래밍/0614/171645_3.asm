
INCLUDE Irvine32.inc

.data
Multiplier DWORD ?
Multiplicand DWORD ?
Result DWORD ?

GetMultiplier BYTE "Enter a Multiplier : ", 0
GetMultiplicand BYTE "Enter a Multiplicand : ", 0
GetResult BYTE "Product : ", 0
GetBye BYTE "Bye!", 0

.code
main PROC
l0:
mov edx, OFFSET GetMultiplier
call WriteString
call ReadHex
cmp eax, 0
je l1
mov Multiplier, eax

mov edx, OFFSET GetMultiplicand
call WriteString
call ReadHex
mov Multiplicand, eax

mov ebx, Multiplier
mov eax, Multiplicand
call BitwiseMultiply
mov Result, eax

mov edx, OFFSET GetResult
call WriteString
mov eax, Result
call WriteHex
call Crlf
call Crlf
jmp l0

l1:
mov edx, OFFSET Getbye
call WriteString
exit
main ENDP

BitwiseMultiply PROC
mov edx, eax
xor eax, eax
bsr ecx, edx
jz r1

r2:
shr edx, 1
jnc r3
add eax, ebx
r3:
shl ebx, 1
add ecx, '-1'
jnc r2

r1:
ret
BitwiseMultiply ENDP

END main
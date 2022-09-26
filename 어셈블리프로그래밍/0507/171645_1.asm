
INCLUDE irvine32.inc

.data
INCLUDE hw1_1.inc

.code
main PROC

mov ebx, val4
mov ecx, val3
sub ebx, ecx ; ebx : val4 - val3
mov ecx, ebx ; ecx : val4 - val3
add ebx, ebx
add ebx, ebx ; ebx : 4*(val4-val3)
add ebx, ecx ; ebx : 5*(val4-val3)
mov ecx, val2
add ecx, ecx
add ecx, ecx
add ecx, ecx
add ecx, ecx ; ecx : 16*val2
mov eax, ecx
add ecx, ecx ; ecx : 32*val2
add ecx, eax ; ecx : 48*val2
mov eax, val2
add ecx, eax
add ecx, eax
add ecx, eax ; ecx : 51*val2
sub ecx, ebx ; ecx : 51*val2 - 5*(val4-val3)
mov eax, val1
add eax, eax
add eax, eax ; eax : 4*val1
mov ebx, eax
add eax, eax
add eax, ebx ; eax : 12*val1
add eax, ecx ; eax : 12*val1 + 51*val2 - 5*(val4-val3)
call DumpRegs ; eval1

mov ebx, val3
mov ecx, val4
sub ebx, ecx ; ebx : val3 - val4
mov ecx, ebx ; ecx : val3 - val4
add ebx, ebx
add ebx, ebx
add ebx, ebx
add ebx, ebx
sub ebx, ecx ; ebx :  15*(val3-val4)
mov ecx, val2
add ecx, ecx
add ecx, ecx
mov eax, ecx ; eax : 4*val2
add ecx, ecx ; ecx : 8*val2
add eax, ecx ; eax : 12*val2
mov ecx, val2
add eax, ecx ; eax : 13*val2
sub eax, ebx ; eax : 13*val2 - 15*(val3 - val4)
mov ebx, val1
add ebx, ebx
mov ecx, ebx ; ecx : 2*val1
add ebx, ebx
add ebx, ebx
add ebx, ebx ; ebx : 16*val1
sub ebx, ecx ; ebx : 14*val1
add eax, ebx ; eax : 14*val1 + 13*val2 - 15*(val3-val4)
call DumpRegs 

mov eax, val1
mov ebx, val2
mov ecx, val3
add eax, ebx
add eax, ecx
mov ebx, eax ; ebx : val2+val2+val3
add eax, eax
add eax, ebx ; eax : 3*(val1+val2+val3)
mov ebx, val4
mov ecx, val4
add ebx, ebx
add ebx, ebx
sub ebx, ecx ; ebx : 3*val4
mov ecx, val2
add ebx, ecx ; ebx : val2 + 3*val4
sub eax, ebx ; eax : 3*(val1+val2+val3)-(val2+3*val4)
mov ebx, val1
add ebx, ebx
add ebx, ebx 
mov ecx, ebx ; ecx : 4*val1
add ebx, ebx
add ebx, ebx ; ebx : 16*val1
add ebx, ecx ; ebx : 20*val1
sub eax, ebx ; eax : 3*(val1+val2+val3)-20*val1-(val2+3*val4)
call DumpRegs 

exit

main ENDP
END main

INCLUDE irvine32.inc

.data
INCLUDE hw1_2.inc

.code
main PROC
mov eax, 0
mov ebx, 0
mov bl, [val1+0]
sub bl, 48 ; bl : n1
mov eax, ebx
add eax, eax
add eax, eax
add eax, eax
sub eax, ebx ; eax : n1*7
mov bl, [val1+1]
sub bl, 48 ; bl : n2
add eax, ebx ; eax : n1*7 + n2
mov ecx, eax ; ecx : n1*7 + n2
add eax, eax
add eax, eax
add eax, eax
sub eax, ecx ; eax : (n1*7 + n2)*7
mov bl, [val1+2]
sub bl, 48 ; bl : n3
add eax, ebx ; eax : (n1*7 + n2)*7 + n3
mov ecx, eax
add eax, eax
add eax, eax
add eax, eax
sub eax, ecx ; eax : ((n1*7 + n2)*7 + n3)*7
mov bl, [val1+3]
sub bl, 48 ; bl : n4
add eax, ebx ; eax : ((n1*7 + n2)*7 + n3)*7 + n4
call DumpRegs

exit
main ENDP
END main
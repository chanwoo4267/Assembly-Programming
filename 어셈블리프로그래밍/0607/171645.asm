
INCLUDE irvine32.inc

.data
CODE_A BYTE '1'
CODE_B BYTE '01'
CODE_C BYTE '000'
CODE_D BYTE '0011'
CODE_E BYTE '0010'

INCLUDE hw3.inc

cA BYTE "A", 0
cB BYTE "B", 0
cC BYTE "C", 0
cD Byte "D", 0
cE BYTE "E", 0

.code
main PROC
;-------------------------initialize
mov ecx, 32 ; loop counter
mov ebx, CODE01
mov esi, 0 ; convert counter
;------------------------ start of loop
l1:

cmp ecx, 0
jbe next

clc
sub ecx, 1
rcl ebx, 1

jc countcheck1 ; if CF is 1, check count
add esi, 1

cmp esi, 3
je countcheck1 ; this means '000' and CF 0, so jump fucn

jmp l1

countcheck1:
call CCandP ; call Function
jmp l1

next:
call Crlf
mov ecx, 32
mov ebx, CODE02
mov esi, 0
l2:

cmp ecx, 0
jbe next2

clc
sub ecx, 1
rcl ebx, 1

jc countcheck2 ; if CF is 1, check count
add esi, 1

cmp esi, 3
je countcheck2 ; this means '000' and CF 0, so jump fucn

jmp l2

countcheck2:
call CCandP ; call Function
jmp l2

next2:

call Crlf
mov ecx, 32
mov ebx, CODE03
mov esi, 0
l3:

cmp ecx, 0
jbe next3

clc
sub ecx, 1
rcl ebx, 1

jc countcheck3 ; if CF is 1, check count
add esi, 1

cmp esi, 3
je countcheck3 ; this means '000' and CF 0, so jump fucn

jmp l3

countcheck3:
call CCandP ; call Function
jmp l3

next3:

call Crlf
mov ecx, 32
mov ebx, CODE04
mov esi, 0
l4:

cmp ecx, 0
jbe next4

clc
sub ecx, 1
rcl ebx, 1

jc countcheck4 ; if CF is 1, check count
add esi, 1

cmp esi, 3
je countcheck4 ; this means '000' and CF 0, so jump fucn

jmp l4

countcheck4:
call CCandP ; call Function
jmp l4

next4:

call Crlf
mov ecx, 32
mov ebx, CODE05
mov esi, 0
l5:

cmp ecx, 0
jbe next5

clc
sub ecx, 1
rcl ebx, 1

jc countcheck5 ; if CF is 1, check count
add esi, 1

cmp esi, 3
je countcheck5 ; this means '000' and CF 0, so jump fucn

jmp l5

countcheck5:
call CCandP ; call Function
jmp l5

next5:

exit
main ENDP

;----------------------
CCandP PROC
;----------------------
;check Counter esi and Print
;----------------------
cmp esi, 0 ; '1'
je printA

cmp esi, 1 ; '01'
je printB

cmp esi, 3 ; '000'
je printC

cmp esi, 2 ; '001'
clc
sub ecx, 1
cmp ecx, -1
je endccandp

rcl ebx, 1
jc printD

jmp printE ; '0010'

printA:
mov edx, offset cA
call WriteString
mov esi, 0
jmp endccandp

printB:
mov edx, offset cB
call WriteString
mov esi, 0
jmp endccandp

printC:
mov edx, offset cC
call WriteString
mov esi, 0
jmp endccandp

printD:
mov edx, offset cD
call WriteString
mov esi, 0
jmp endccandp

printE:
mov edx, offset cE
call WriteString
mov esi, 0

endccandp:
ret
CCandP ENDP



END main
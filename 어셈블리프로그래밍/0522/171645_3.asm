
INCLUDE irvine32.inc
BUFMAX = 100
WORDMAX = 100

.data
sType BYTE "Type_A_String: ",0
wType BYTE "a_Word_for_Search: ", 0
sFound BYTE "Found",0
sNotFound BYTE "Not Found",0
sExit Byte "Bye!", 0

buffer BYTE BUFMAX DUP(0)
bufferword BYTE WORDMAX DUP(0)
bufSize DWORD ?
wordSize DWORD ?

.code
main PROC
top:
call InputTheString
call InputTheWord
call FindWord

jmp top
exit
main endp

;-------------------------------------
InputTheString PROC
;-------------------------------------
pushad
reinput:
mov edx, OFFSET sType
call WriteString
mov ecx, BUFMAX
mov edx, offset buffer
call ReadString
mov bufsize, eax
cmp eax, 0
je exitfunc
cmp eax, 40
ja reinput

jmp noexit

exitfunc:
mov edx, OFFSET sExit
call WriteString
exit

noexit:
popad
ret
InputTheString ENDP

;-----------------------------------
InputTheWord PROC
;-----------------------------------
pushad
mov edx, OFFSET wType
call WriteString
mov ecx, WORDMAX
mov edx, offset bufferword
call ReadString
mov wordSize, eax
popad
ret
InputTheWord ENDP

;--------------------------------
FindWord PROC
;--------------------------------
pushad
mov eax, 0
mov ebx, 0
mov ecx, 0
mov edx, bufSize
sub edx, wordSize
add edx, 1 ; end check var 'edx'
mov esi, 0

start:
cmp ebx, edx
jae notfound
cmp eax, wordSize
jae foundcheck

push eax
mov al, bufferword[eax]
cmp buffer[esi], al ;
je same
pop eax

notsame:

mov eax, 0 ; initialize word index
add ebx, 1 ; string search start index + 1
mov esi, ebx ; initialize string index
jmp start

same:
pop eax
add esi, 1
add eax, 1
jmp start

foundcheck:
push ebx
sub ebx, 1
cmp ebx, -1
je next1
cmp buffer[ebx], ' '
je next1
cmp buffer[ebx], '?'
je next1
cmp buffer[ebx], ','
je next1
cmp buffer[ebx], '"'
je next1
cmp buffer[ebx], '!'
je next1
cmp buffer[ebx], '.'
je next1

nofind:
pop ebx
jmp notsame

next1:
add ebx, 1
add ebx, wordSize
cmp buffer[ebx], ' '
je found
cmp buffer[ebx], '?'
je found
cmp buffer[ebx], ','
je found
cmp buffer[ebx], '"'
je found
cmp buffer[ebx], '!'
je found
cmp buffer[ebx], '.'
je found
cmp ebx, bufSize
je found
jmp nofind

notfound:
mov edx, OFFSET sNotFound
call DisplayMessage
jmp something

found:
pop ebx
mov edx, OFFSET sFound
call DisplayMessage

something:

popad
ret
FindWord ENDP

;------------------------------
DisplayMessage PROC
;------------------------------
pushad
call WriteString
popad
call Crlf
ret
DisplayMessage ENDP

END main



INCLUDE irvine32.inc
BUFMAX = 40
KEYMAX = 10

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

.code
main PROC
top:
call InputTheString
call InputTheKey
call Crlf
mov edx, OFFSET sOrigin
call DisplayMessage
call TranslateBuffer
mov edx, OFFSET sEncrypt
call DisplayMessage
call TranslateBuffer
mov edx, OFFSET sDecrypt
call DisplayMessage
call Crlf
jmp top
exit
main endp

;-------------------------------------
InputTheString PROC
;-------------------------------------
pushad
reinput:
mov edx, OFFSET sPrompt
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
InputTheKey PROC
;-----------------------------------
pushad
mov edx, OFFSET sKey
call WriteString
mov ecx, KEYMAX
mov edx, offset dkey
call ReadString
mov keySize, eax
popad
ret
InputTheKey ENDP

;------------------------------
DisplayMessage PROC
;------------------------------
pushad
call WriteString
mov edx, OFFSET buffer
call WriteString
popad
call Crlf
ret
DisplayMessage ENDP

;--------------------------------
TranslateBuffer PROC
;--------------------------------
pushad
mov ecx, bufsize
mov esi,0
mov eax,0
l1:
cmp eax, keySize
jae refresh
jmp norefresh
refresh:
mov eax, 0
norefresh:
mov bl, dkey[eax]
xor buffer[esi], bl
inc esi
inc eax
loop l1

popad
ret
TranslateBuffer ENDP
END main


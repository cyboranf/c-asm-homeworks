         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         call getaddr
rowne:   db "a == b", 0xA, 0
length   equ $ - rowne
rozne:   db "a != b", 0xA, 0
getaddr:

;        esp -> [rowne][ret]

a        equ 6
b        equ 6

         mov eax, a  ; eax = a
         mov ecx, b  ; ecx = b

         cmp eax, ecx  ; eax - ecx         ; OF SF ZF AF PF CF affected

         je equal      ; jump if equal     ; jump if eax == ecx ; jump if ZF = 1
         jne notequal  ; jump if not equal ; jump if eax != ecx ; jump if ZF = 0

notequal add dword [esp], length  ; *(int*)esp = *(int*)esp + length = rozne

;        esp -> [rozne][ret]

equal    call [ebx+3*4]  ; printf(format);
         add esp, 1*4    ; esp = esp + 4

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

; asmloader API
;
; ESP wskazuje na prawidlowy stos
; argumenty funkcji wrzucamy na stos
; EBX zawiera pointer na tablice API
;
; call [ebx + NR_FUNKCJI*4] ; wywolanie funkcji API
;
; NR_FUNKCJI:
;
; 0 - exit
; 1 - putchar
; 2 - getchar
; 3 - printf
; 4 - scanf
;
; To co funkcja zwr�ci jest w EAX.
; Po wywolaniu funkcji sciagamy argumenty ze stosu.
;
; https://gynvael.coldwind.pl/?id=387


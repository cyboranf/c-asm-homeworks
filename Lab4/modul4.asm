        [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         call getaddr  ; push on the stack the runtime address of format and jump to getaddr
format:
         db 'liczba = ', 0
getaddr:

;        esp -> [format][ret]

         call [ebx+3*4]  ; printf('liczba = ');


         push esp  ; esp -> stack

;        esp -> [addr_a][format][ret]

         call getaddr2  ; push on the stack the runtime address of format and jump to getaddr
format2:
         db '%d', 0
getaddr2:

;        esp -> [format2][addr_a][format][ret]

         call[ebx+4*4]   ; scanf(format2, addr_a);
         
;        esp -> [a][format2][addr_a][format][ret]

         add esp, 2*4    ; esp = esp + 8

;        esp -> [addr_a][format][ret]

         pop eax

         test eax, eax  ; eax - 0                   ; OF SF ZF AF PF CF affected
         jge nieujemna  ; jump if greater or equal  ; jump if SF == OF or ZF = 1

         neg eax          ; eax = -eax

nieujemna:

         push eax  ; eax -> stack

;        esp -> [eax][addr_a][format][ret]



         call getaddr3  ; push on the stack the runtime address of format and jump to getaddr
format3:
         db 'modul = %d', 0xA, 0
getaddr3:

;        esp -> [format3][eax][addr_a][format][ret]

         call [ebx+3*4]  ; printf("a = %d\n",a)
         add esp, 4*4      ; esp = esp + 16

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

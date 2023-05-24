         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ 131
b        equ 130

;        10000011  al
;      & 10000010  cl
;        --------
;        10000010

         mov al, a  ; al = a
         mov cl, b  ; cl = b

         test al, cl  ; al & cl  ; OF=0 SF ZF PF CF=0 affected

         mov eax, 0  ; eax = 0

         setc al   ; al = CF
         push eax  ;

         setp al   ; al = PF
         push eax  ;

         setz al   ; al = ZF
         push eax  ;

         sets al   ; al = SF
         push eax  ;

         seto al   ; al = OF
         push eax  ;

;        esp -> [OF][SF][ZF][PF][CF][ret]

         call getaddr
format:
         db "OF = %u", 0xA, 0xA
         db "SF = %u", 0xA,
         db "ZF = %u", 0xA
         db "PF = %u", 0xA, 0xA
         db "CF = %u", 0xA, 0
getaddr:

;        esp -> [format][OF][SF][ZF][PF][CF][ret]

         call [ebx+3*4]  ; printf(format, OF, SF, ZF, PF, CF);
         add esp, 6*4    ; esp = esp + 24

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
; To co funkcja zwróci jest w EAX.
; Po wywolaniu funkcji sciagamy argumenty ze stosu.
;
; https://gynvael.coldwind.pl/?id=387
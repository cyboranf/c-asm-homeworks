         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

%ifdef COMMENT
* Liczby bez znaku

         <  jb jnae jc    a above
         <= jbe jna       b below
         == je jz         e equal
         != jne jnz       n not
         >  jnbe ja
         >= jnb jae jnc

* Liczby ze znakiem

         <  jl jnge       l less
         <= jng jle       g greater
         == je jz         e equal
         != jne jnz       n not
         >  jg jnle
         >= jnl jge

%endif
         jmp always  ; jump always

always   cmp eax, edx  ; eax - edx ; OF SF ZF AF PF CF affected

;        * Liczby bez znaku

;        jump if eax < edx

         jb skip1    ; jump if below              ; jump if CF = 1
         jnae skip1  ; jump if not above or equal ; jump if CF = 1
         jc skip1    ; jump if carry set          ; jump if CF = 1

;        jump if eax <= edx

skip1    jbe skip2  ; jump if below or equal ; jump if CF = 1 or ZF = 1
         jna skip2  ; jump if not above      ; jump if CF = 1 or ZF = 1

;        jump if eax > edx

skip2    jnbe skip3  ; jump if not below or equal ; jump if CF = 0 and ZF = 0
         ja skip3    ; jump if above              ; jump if CF = 0 and ZF = 0

;        jump if eax >= edx

skip3    jnb skip4  ; jump if not below      ; jump if CF = 0 or ZF = 1
         jae skip4  ; jump if above or equal ; jump if CF = 0 or ZF = 1
         jnc skip4  ; jump if carry not set  ; jump if CF = 0 or ZF = 1

;        * Liczby ze znakiem

;        jump if eax < edx

skip4    jl skip5    ; jump if less                 ; jump if SF != OF
         jnge skip5  ; jump if not greater of equal ; jump if SF != OF

;        jump if eax <= edx

skip5    jng skip6  ; jump if not greater   ; jump if SF != OF or ZF = 1
         jle skip6  ; jump if less or equal ; jump if SF != OF or ZF = 1

;        jump if eax > edx

skip6    jg skip7    ; jump if greater           ; jump if SF == OF and ZF = 0
         jnle skip7  ; jump if not less or equal ; jump if SF == OF and ZF = 0

;        jump if eax >= edx

skip7    jnl skip8  ; jump if not less         ; jump if SF == OF or ZF = 1
         jge skip8  ; jump if greater or equal ; jump if SF == OF or ZF = 1

skip8:

         push 0         ; esp -> [0][ret]
         call [ebx+0*4] ; exit(0);

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

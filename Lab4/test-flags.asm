         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         jc skip1   ; jump if carry set     ; CF = 1
         jnc skip1  ; jump if carry not set ; CF = 0

skip1    jp skip2   ; jump if parity set     ; PF = 1
         jnp skip2  ; jump if parity not set ; PF = 0

skip2    jz skip3   ; jump if zero  ; ZF = 1
         je skip3   ; jump if equal ; ZF = 1

skip3    jnz skip4  ; jump if not zero  ; ZF = 0
         jne skip4  ; jump if not equal ; ZF = 0

skip4    js skip5   ; jump if sign set ; SF = 1
         jns skip5  ; jump if not sign ; SF = 0

skip5    jo skip6   ; jump if overflow     ; OF = 1
         jno skip6  ; jump if not overflow ; OF = 0

skip6    push 0          ; esp -> [0][ret]
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

         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         finit

;        st = []  ; fpu stack

         fld1    ; fpu load 1
         fldz    ; fpu load 0
         fldpi   ; fpu load pi
         fldl2e  ; fpu load log2(e)
         fldln2  ; fpu load ln(2)
         fldl2t  ; fpu load log2(10)
         fldlg2  ; fpu load log10(2)

;        st = [st0, st1, st2, st3, st4, st5, st6] = [log10(2), log2(10), ln(2), log2(e), pi, 0, 1]

         sub esp, 7*2*4  ; esp = esp - 48

;        esp -> [ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ret]

         call getaddr
format:
         db "one      = %f", 0xA
         db "zero     = %f", 0xA
         db "pi       = %f", 0xA
         db "log2(e)  = %f", 0xA
         db "ln(2)    = %f", 0xA
         db "log2(10) = %f", 0xA
         db "log10(2) = %f", 0xA, 0
getaddr:

;                       +4    +12   +20   +28   +36   +44   +52
;        esp -> [format][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ret]

         fstp qword [esp+52]  ; *(double*)(esp+52) <- st = log10(2)
         fstp qword [esp+44]  ; *(double*)(esp+52) <- st = log2(10)
         fstp qword [esp+36]  ; *(double*)(esp+52) <- st = ln(2)
         fstp qword [esp+28]  ; *(double*)(esp+52) <- st = log2(e)
         fstp qword [esp+20]  ; *(double*)(esp+52) <- st = pi
         fstp qword [esp+12]  ; *(double*)(esp+52) <- st = zero
         fstp qword [esp+04]  ; *(double*)(esp+52) <- st = one

;        st = []

         call [ebx+3*4]      ; printf(format, ...);
         add esp, 4 + 7*2*4  ; esp = esp + 52

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



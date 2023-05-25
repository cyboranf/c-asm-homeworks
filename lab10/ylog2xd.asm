         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

x        equ __?float64?__(256.0)

         sub esp, 2*4  ; esp = esp - 8 ; make room for double type result

;        esp -> [ ][ ][ret]

         call getaddr  ; get the runtime address of format

format   db "log2 = %f", 0xA, 0
length   equ $ - format

addr_y   dq 1.0  ; define quad word
addr_x   dq x    ; define quad word

getaddr:

;        esp -> [format][ ][ ][ret]

;        FYL2X       st(1) := st(1)*log2[st(0)] i zdejmij

         finit  ; fpu init

;        st = []

         mov eax, [esp]   ; eax = *(int*)esp = format
         add eax, length  ; eax = eax + length = format + length = addr_y
         
         fld qword [eax]  ; *(double*)eax = *(double*)addr_y = 1 -> st ; fpu load floating-point

;        st = [st0] = [1]  ; fpu stack

         fld qword [eax+8]  ; *(double*)eax = *(double*)addr_x = x -> st ; fpu load floating-point

;        st = [st0, st1] = [x, 1]  ; fpu stack

         fyl2x 

;                       +4
;        esp -> [format][ ][ ][ret]

         fstp qword [esp+4]  ; *(double*)(esp+4) <- st = [sqrt(x)]  ; fpu store top element
                                                                    ; and pop fpu stack
;        st = []  ; fpu stack

         call [ebx+3*4]  ; printf("sqrt = %f\n", *(double*)(esp+4));
         add esp, 3*4    ; esp = esp + 12

;        esp -> [ret]

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
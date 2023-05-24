         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

x        equ 5

         sub esp, 2*4  ; esp = esp - 8 ; make room for double type result

;        esp -> [ ][ ][ret]

         call getaddr  ; get the runtime address of format

format   db "sqrt = %f", 0xA, 0
length   equ $ - format
addr_x   dd x                    ; define double word

getaddr:

;        esp -> [format][ ][ ][ret]

         finit  ; fpu init

         mov eax, [esp]   ; eax = *(int*)esp = format
         add eax, length  ; eax = eax + length = format + length = addr_x

         fild dword [eax]  ; *(int*)eax = *(int*)addr_x = x -> st  ; fpu load integer

;        st = [st0] = [x]  ; fpu stack

         fsqrt  ; [st0] => [sqrt(st0)] = [sqrt(x)]

;        st = [st0] = [sqrt(x)]  ; fpu stack

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
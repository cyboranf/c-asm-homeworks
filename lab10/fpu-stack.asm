         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ 3
b        equ __?float32?__(3.141592)
c        equ __?float64?__(3.141592653589793)

         call getaddr

addr_a   dd a  ; [ ][ ][ ][ ]              ; define double word
addr_b   dd b  ; [ ][ ][ ][ ]              ; define double word
addr_c   dq c  ; [ ][ ][ ][ ][ ][ ][ ][ ]  ; define quad word

getaddr:

;        esp -> [addr_a][ret]

         mov eax, [esp]  ; eax = *(int*)esp = addr_a

         finit  ; fpu init

;        st = []

         fldpi  ; fpu load pi

;        st = [st0] = [pi]

         fld qword [eax+8]  ; *(double*)(eax+8) = *(double*)addr_c = c -> st ; fpu load floating-point

;        st = [st0, st1] = [c, pi]

         fld dword [eax+4]  ; *(float*)(eax+4) = *(float*)addr_b = b -> st ; fpu load floating-point

;        st = [st0, st1, st2] = [b, c, pi]

         fild dword [eax]  ; *(int*)eax = *(int*)addr_a = a -> st ; fpu load integer

;        st = [st0, st1, st2, st3] = [a, b, c, pi]

         sub esp, 3*8  ; esp = esp + 24

;                  +4    +12   +20
;        esp -> [a][b][ ][c][ ][pi][ ][ret]

         fistp dword [esp]  ; *(int*)esp <- st = a ; fpu store integer and pop

;        st = [st0, st1, st2] = [b, c, pi]

         fstp qword [esp+4]  ; *(double*)(esp+4) <- st = b ; fpu store floating-point value and pop

;        st = [st0, st1] = [c, pi]

         fstp qword [esp+12]  ; *(double*)(esp+12) <- st = c ; fpu store floating-point value and pop

;        st = [st0] = [pi]

         fst qword [esp+20]  ; *(double*)(esp+20) <- st = pi ; fpu store floating-point value ; peek

;        st = [st0] = [pi]

         call getaddr2
format2:
         db "a  = %d", 0xA
         db "b  = %.15f", 0xA
         db "c  = %.15f", 0xA
         db "pi = %.15f", 0xA, 0
getaddr2:

;        esp -> [format2][a][b][ ][c][ ][pi][ ][ret]

         call [ebx+3*4]  ; printf(format2, a, b, c, pi);
         add esp, 8*4    ; esp = esp + 32

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

%ifdef COMMENT

ebx    -> [ ][ ][ ][ ] -> exit
ebx+4  -> [ ][ ][ ][ ] -> putchar
ebx+8  -> [ ][ ][ ][ ] -> getchar
ebx+12 -> [ ][ ][ ][ ] -> printf
ebx+16 -> [ ][ ][ ][ ] -> scanf

%endif

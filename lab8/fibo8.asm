        [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader
%ifdef COMMENT
a   b      a+2b
|---|   |---|
1   1   2   3   5   8   13   wartosci
    |---|   |---|
    b  a+b    2a+3b

Przesuniecie ramki:

xadd (b, a) = (a+b, b) // wynik w rejestrze b

Schemat obliczeñ:

                xadd        xadd           xadd
(a, b) -> (b, a) => (a+b, b) => (a+2b, a+b) => (2a+3b, a+2b) => ...


%endif

n        equ 4

         mov ebp, ebx  ; ebp = ebx

         mov ecx, n  ; ecx = n
         sub ecx, 2  ; subtract 2 to facilitate single cmp instruction

         mov eax, 1  ; eax = 1
         mov ebx, 1  ; ebx = 1

         cmp ecx, -2  ; -2 represents original n=0

         jg continue   ; jump if greater (n > 0)
         je push_eax  ; jump if equal (n = 0)
         jmp done     ; less than (n < 0), should not happen but for completeness

push_eax:
         push eax
         jmp done

continue:
         cmp ecx, -1  ; -1 represents original n=1
         jg shift     ; jump if greater (n > 1)
         je push_ebx  ; jump if equal (n = 1)

push_ebx:
         push ebx
         jmp done

shift:  
         xadd eax, ebx  ; xadd(b, a) = (a+b,b)
         dec ecx  ; ecx = ecx - 1
         jns shift  ; jump if not negative

done:
         push ebx  ; ebx -> stack

         call getaddr ; push on the stack the runtime address of format and jump getaddr
format:
         db 'fibo = %d', 0xA, 0
getaddr:

         call [ebp+3*4]  ; printf(format, ebx);
         add esp, 2*4      ; esp = esp + 8

         push 0          ; esp -> [0][ret]
         call [ebp+0*4]  ; exit(0);
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
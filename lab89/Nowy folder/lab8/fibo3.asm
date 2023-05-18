         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

%ifdef COMMENT
0   1   2   3   4   5   6    indeksy

a   b
|---|
1   1   2   3   5   8   13   wartosci
|   |---|
d   a   b

Przesuniecie ramki:

d = a              ; d = 1
a = b              ; a = 1
b = a + d = b + d  ; b = 1 + 1 = 2
%endif

n        equ 4

         mov ebp, ebx  ; ebp = ebx

         mov ecx, n  ; ecx = n

         mov eax, 1  ; eax = 1
         mov ebx, 1  ; ebx = 1

         cmp ecx, 0  ; eax - ecx         ; OF SF ZF AF PF CF affected
         jne next1   ; jump if not equal ; ZF = 0

         push eax  ; eax -> stack

;        esp -> [eax][ret]

         jmp done

next1    cmp ecx, 1  ; ecx - 1           ; OF SF ZF AF PF CF affected
         jne next2   ; jump if not equal ; ZF = 0

         push ebx    ; ebx -> stack

;        esp -> [ebx][ret]

         jmp done

next2    sub ecx, 1  ; ecx = ecx - 1

shift    mov edx, eax  ; d = a
         mov eax, ebx  ; a = b
         add ebx, edx  ; b = b + d

         loop shift

done:    push ebx    ; ebx -> stack

;        esp -> [ebx][ret]


         call getaddr  ; push on the stack the runtime address of format and jump to getaddr
format:
         db 'fibo = %d', 0xA, 0
getaddr:

;        esp -> [format][ebx][ret]

         call [ebp+3*4]  ; printf(format, ebx);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [ret]

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

         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         call getaddr
format:
        db 'znak = ', 0
getaddr:

;        esp -> [format][ret]

         call [ebx+3*4]  ; printf('znak = ');
         add esp, 4    ; esp = esp + 4

;        esp -> [ret]

         call [ebx+2*4]  ; eax = getchar();

         push eax  ; eax -> stack
         
;        esp -> [eax][ret]

         call getaddr2
format2:
        db 'ascii = %02X', 0xA, 0
getaddr2:

;        esp -> [format2][eax][ret]

         call [ebx+3*4]  ; printf('ascii = %02X\n', eax);
         add esp, 2*4    ; esp = esp + 8

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

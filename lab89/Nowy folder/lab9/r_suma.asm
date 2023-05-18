%ifdef COMMENT
suma(n) = 0 + 1 + 2 + ... + n

suma(0) = 0
suma(n) = n + suma(n-1)

suma(0) = 0
suma(1) = 1
suma(2) = 3
suma(3) = 6
suma(4) = 10
suma(5) = 15
%endif

         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

n        equ 5

         mov ecx, n  ; ecx = n

         call suma   ; eax = suma(ecx) ; fastcall

addr:

;        esp -> [ret]

         push eax

;        esp -> [eax][ret]

         call getaddr
format:
         db "suma = %i", 0xA, 0
getaddr:

;        esp -> [format][eax][ret]

         call [ebx+3*4]  ; printf("suma = %i\n", eax);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

;        eax suma(ecx)

suma     cmp ecx, 0    ; ecx - 0           ; ZF affected
         jne rec       ; jump if not equal ; jump if ZF = 0
         mov eax, ecx  ; eax = ecx = 0
         ret

rec      push ecx      ; ecx -> stack = n
         dec ecx       ; ecx = ecx - 1 = n-1
         call suma     ; eax = suma(ecx) = suma(n-1)
         pop ecx       ; ecx <- stack = n
         add eax, ecx  ; eax = eax + ecx = suma(n-1) + n
         ret

; suma(0) = 0
; suma(n) = n + suma(n-1)

%ifdef COMMENT
eax = suma(ecx)

* suma(1) =           * suma(1) = 1
  ecx -> stack = 1      ecx -> stack = 1
  ecx = ecx - 1 = 0     ecx = ecx - 1 = 0
  eax = suma(0) =       eax = suma(0) = 0
  ecx <- stack = 1      ecx <- stack = 1
  eax = eax + ecx =     eax = eax + ecx = 0 + 1 = 1
  return eax =          return eax = 1

* suma(0) =           * suma(0) = 0
  eax = ecx = 0         eax = ecx = 0
  return eax = 0        return eax = 0
%endif

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

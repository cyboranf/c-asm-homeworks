%ifdef COMMENT
silnia podwojna(n) = 1 * 3 * ... * n (dla nieparzystych)
silnia podwojna(n) = 2 * 4 * ... * n (dla parzystych)

0!! = 1
1!! = 1
n!! = n*(n-2)!!

silnia podwojna(0) = 1
silnia podwojna(1) = 1
silnia podwojna(n) = n * silnia podwojna(n-2)
%endif

         [bits 32]

n        equ 5

         mov ecx, n    

         call silnia_podwojna   

addr:

         push eax
         push format
         call [ebx+3*4]  
         add esp, 2*4    

         push 0          
         call [ebx+0*4]  

silnia_podwojna:
         cmp ecx, 1
         jle koniec
         sub ecx, 2

         push ecx
         call silnia_podwojna
         pop ecx

         add ecx, 2
         imul eax, ecx
         ret

koniec:
         mov eax, 1
         ret

format:
         db "Podwojna silnia = %i", 0xA, 0

%ifdef COMMENT
eax = silnia_podwojna(ecx)

* silnia_podwojna(2) =         * silnia_podwojna(2) = 2
  ecx = ecx - 2 = 0              ecx = ecx - 2 = 0
  eax = silnia_podwojna(0) =     eax = silnia_podwojna(0) = 1
  ecx = ecx + 2 = 2              ecx = ecx + 2 = 2
  eax = eax * ecx =              eax = eax * ecx = 1 * 2 = 2
  return eax =                   return eax = 2

* silnia_podwojna(0) =         * silnia_podwojna(0) = 1
  eax = 1                        eax = 1
  return eax = 1                 return eax = 1
%endif

%ifdef COMMENT
eax = silnia_podwojna(ecx)

* silnia_podwojna(5) =         * silnia_podwojna(5) = 15
  ecx = ecx - 2 = 3              ecx = ecx - 2 = 3
  eax = silnia_podwojna(3) =     eax = silnia_podwojna(3) = 3
  ecx = ecx + 2 = 5              ecx = ecx + 2 = 5
  eax = eax * ecx =              eax = eax * ecx = 3 * 5 = 15
  return eax =                   return eax = 15

* silnia_podwojna(3) =         * silnia_podwojna(3) = 3
  ecx = ecx - 2 = 1              ecx = ecx - 2 = 1
  eax = silnia_podwojna(1) =     eax = silnia_podwojna(1) = 1
  ecx = ecx + 2 = 3              ecx = ecx + 2 = 3
  eax = eax * ecx =              eax = eax * ecx = 1 * 3 = 3
  return eax =                   return eax = 3

* silnia_podwojna(1) =         * silnia_podwojna(1) = 1
  eax = 1                        eax = 1
  return eax = 1                 return eax = 1
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

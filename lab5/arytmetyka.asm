         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

;        Negacja

         neg eax  ; eax = -eax

;        Dodawanie

         add eax, ecx  ; eax = eax + ecx

;        Dodawanie z przeniesieniem

         adc eax, ecx  ; eax = ecx + ecx + CF

;        Odejmowanie

         sub eax, ecx  ; eax = eax - ecx

;        Odejmowanie z pozyczka

         sbb eax, ecx  ; eax = eax - ecx - CF

;        Mnozenie bez znaku

         mul ecx  ; edx:eax = eax*ecx

;        mul arg  ; edx:eax = eax*arg

;        Mnozenie ze znakiem

         imul ecx  ; edx:eax = eax*ecx

;        imul arg  ; edx:eax = eax*arg

;        Dzielenie bez znaku liczby 64-bitowej edx:eax przez argument

         div ecx     ; eax = edx:eax / ecx  ; iloraz
                     ; edx = edx:eax % ecx  ; reszta

;        div arg     ; eax = edx:eax / arg  ; iloraz
                     ; edx = edx:eax % arg  ; reszta

;        Dzielenie ze znakiem liczby 64-bitowej edx:eax przez argument

         idiv ecx    ; eax = edx:eax / ecx  ; iloraz
                     ; edx = edx:eax % ecx  ; reszta

;        idiv arg    ; eax = edx:eax / arg  ; iloraz
                     ; edx = edx:eax % arg  ; reszta

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
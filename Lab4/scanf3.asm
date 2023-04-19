    [bits 32]

extern   _printf
extern   _scanf
extern   _exit

section .data
    format db "%d", 0          ; format string for printf
    a resw 1                   ; allocate 2 bytes for integer variable a
    message db 'a = ', 0x, 0
    message2 db 'a = %d', 0x, 0

section .text
    global _start

_start:
;        esp -> [ret]  ; return address

         push a  ; a -> stack

;        esp -> [a][ret]

         push message   ; *(int*)(esp-4) = format ; esp = esp - 4

;        esp -> [message][a][ret]

         call _printf  ; printf("a = ");

         add esp, 4
;        esp -> [a][ret]

         push esp  ; esp -> stack
         
;        esp -> [addr_a][a][ret]

         push format

;        esp -> [format][addr_a][a][ret]

         call _scanf     ; scanf(format2, addr_a)
         add esp, 2*4    ; esp = esp + 8

;        esp -> [a][ret]

         push message2
         
;        esp -> [message2][a][ret]

         call _printf  ; printf("a = %d\n", a)
         add esp, 2*4    ; esp = esp + 8
;        esp -> [ret]

         push 0       ; esp -> [0][ret]
         call _exit   ; exit(0);

%ifdef COMMENT
Kompilacja:

nasm scanf3.asm -o scanf3.o -f win32

ld scanf3.o -o scanf3.exe c:\windows\system32\msvcrt.dll -m i386pe

lub:

nasm scanf3.asm -o scanf3.o -f win32

gcc scanf3.o -o scanf3.exe -m32
%endif
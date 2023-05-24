#include <stdio.h>

int main() {
    printf("div.c\n\n");
    
    unsigned int a = 4294967295u;
    unsigned int b = 4;
    
    printf("a = %u\n", a);
    printf("b = %u\n\n", b);
    
    unsigned int iloraz = a/b;
    unsigned int reszta = a%b;
    
    printf("iloraz = %u\n", iloraz);
    printf("reszta = %u\n", reszta);
    
    return 0;
}

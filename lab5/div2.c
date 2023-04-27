#include <stdio.h>

int main() {
    printf("div2.c\n\n");
    
    unsigned long long a = 4294967296;
    unsigned long long b = 3;
    
    printf("a = %llu\n", a);
    printf("b = %llu\n\n", b);
    
    unsigned long long iloraz = a/b;
    unsigned long long reszta = a%b;
    
    printf("iloraz = %llu\n", iloraz);
    printf("reszta = %llu\n", reszta);
    
    return 0;
}


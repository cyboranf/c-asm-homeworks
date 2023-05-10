#include <stdio.h>

int main() {
    printf("idiv.c \n\n");
    
    long long a = -2147483648LL;
    long long b = -3LL;
    
    printf("a = %lld\n", a);
    printf("b = %lld\n\n", b);
    
    long long iloraz = a / b;
    long long reszta = a % b;
    
    printf("iloraz = %lld\n", iloraz);
    printf("reszta = %lld\n", reszta);
       
    return 0;
}

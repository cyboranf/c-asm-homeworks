#include <stdio.h>

int main() {
    printf("idiv.c \n\n");
    
    int a = -2147483648u;
    int b = -3;
    
    printf("a = %d\n", a);
    printf("b = %d\n\n", b);
    
    int iloraz = a / b;
    int reszta = a % b;
    
    printf("iloraz = %d\n",iloraz);
    printf("reszta = %d\n",reszta);
       
    return 0;
}

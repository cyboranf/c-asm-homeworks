#include <stdio.h>

int main() {
    printf("add4.c \n\n");
    
    unsigned int a = 4294967295u;
    unsigned int b = 1;
    unsigned long long suma = (long long)a +  (long long)b;
    
    printf("suma = %llu\n", suma);
    
    return 0;
}

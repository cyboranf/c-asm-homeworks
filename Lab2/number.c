#include <stdio.h>
#include <math.h>

/*
 0  1  2  3
[1][0][5][1] = 1*256^0 + 0*256^1 + 5*256^2 + 1*256^3

*/

int polinomial(unsigned char *p, int n) {
    unsigned int suma = 0;
    
    int i;
    for (i=0; i < n; i++){
        suma = suma + *(p + i)*pow(256,i);
    }
    
    return suma;
}

int horner(unsigned char *p, int n, int w ) {
    unsigned int suma = *(p + (n-1));

    int i;
    for (i = n - 2; i >= 0; i--) {
    	suma = suma * w + p[i];
    }
    
  	return suma;
}

int main() {
    printf("number.c\n\n");
        
    unsigned char x [] = {255,255,255,255};//{1,0,5,1};
    
//    int n = sizeof(x);
    
    // number(0061FE94, 4) = 16711680
    
//    printf("number(%p, %d) = %u\n", x, n, polinomial(x,n));
    
    
    printf("horner.c\n\n");
    
    unsigned char p [] = {255,255,255,255};
    
    int n = sizeof(p);
    int w = 2;
	 
    printf("w(%d) = %u\n", w, horner(p, n, w));
	
    return 0;   
}

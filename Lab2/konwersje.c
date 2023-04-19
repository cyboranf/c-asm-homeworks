#include <stdio.h>
#include <math.h>

/*

- jak¹ maksymaln¹ liczbê binarn¹ mo¿na zapisaæ przy pomocy typu int?

UINT_MAX = 4294967295
INT_MAX  = 2147483647
UBIN_MAX = 1111111111

Odp: Za pomoc¹ typu int maksymalna liczba binarna to: 1111111111

INT_MIN = -2147483648
INT_MAX = 2147483647

- jaka jest wartoœæ dziesiêtna maksymalnej liczby binarnej, jak¹ mo¿na zapisaæ przy pomocy typu int?

           9876543210
UBIN_MAX = 1111111111 = 2^10 - 1 = 1023

*/

/* 
   
11 / 2 = 5   r0 = 1
5 / 2 = 2    r1 = 1
2 / 2 = 1    r2 = 0
1 / 2 = 0    r3 = 1

11 = 1011 = 1*10^0 + 1*10^1 + 0*10^2 + 1*10^3

*/

int dec2bin(int x) {
  int suma = 0;
  int pow = 1;
  
  while (x > 0) {
      suma = suma + x%2 * pow;
      
      x = x/2;
      
      pow = pow*10;
  }
  
  return suma;
}

int bin2dec(int x){
    int decimal = 0;
    int i = 0;

    while(x > 0)
    {
        int bit = x % 10;
        decimal += bit * pow(2, i);
        x /= 10;
        i++;
    }

    return decimal;
}

void dec2byte(unsigned int x) {
    int litleEndian[4] = {0,0,0,0};
    int i = 0;
    int reszta;
    
    for(;;){
        if(x > 256){
            reszta = x % 256;
            litleEndian[i] = reszta;
            x = (x - reszta)/256;
            i++;
        }else{
            litleEndian[i] = x;
            
            break;
        }
    }
    int j = 0;
    for(j; j < 4; j++){
        if(litleEndian[j] < 10){
            printf("[00%d] " ,litleEndian[j]);
        }
        else if(litleEndian[j] < 100){
            printf("[0%d] " ,litleEndian[j]);
        }else{
            printf("[%d] " ,litleEndian[j]);
        }
    }
}

int main() {
    printf("konwersje.c\n\n");
    
    int dec1 = 1023; // dec = 0..1023
    int dec2 = 1011; 
    
    printf("dec2bin(%d) = %d\n", dec1, dec2bin(dec1));
    printf("bin2dec(%d) = %d\n", dec2, bin2dec(dec2));
    printf("dec2byte = ");
    dec2byte(1023);
    
    //dec2bin(1023) = 1111111111;
    //bin2dec(1011) = 11
    //dec2byte = [255] [003] [000] [000]
    
    return 0;   
}

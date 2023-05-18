#include <stdio.h>

int silnia(int n) {
    if (n == 0)
        return 1;
    else
        return n*silnia(n-1);
}

/*
- dokonaj analizy wywo³ania silnia(3)

* silnia1(3) = 6
  n = 3 
  return 3*silnia2(2) = 3*2 = 6 

* silnia2(2) = 2
  n = 2 
  return 2*silnia3(1) = 2*1 = 2
  
* silnia3(1) = 1
  n = 1
  return 1*silnia4(0) = 1*1 = 1
    
* silnia4(0) = 1
  n = 0 
  return 1
*/

/*
- narysuj graf wywo³añ dla silnia(3)

silnia1(3) -> silnia2(2) -> silnia3(1) -> silnia4(0)  
*/

int main(){
    printf("silnia.c\n\n");
    
    int n = 3;
    
    printf("%d! = %d\n", n, silnia(n)); 
    
    return 0;
}

#include <stdio.h>

/*

r1  r2  r3
|---|---|       .
1   2   3   4   5   6    indeksy
3   4   8   12  22  35   wartoœci
    |---|---|
    r1  r2  r3

Przesuniêcie ramki w prawo:

r3 = 0.5 * r2 + 2 * r1
r1 = r2
r2 = r3

*/

int seq1(int n) {
    int r1 = 3;
	int r2 = 4;
	int r3;
    
    if (n == 1) return r1; 
	if (n == 2) return r2;
   
   	int i;
    for (i = 1; i <= n-2; i++) {
    	r3 = 0.5 * r2 + 2 * r1;
    	r1 = r2;
   		r2 = r3;
    }
    
	return r3;
}

/*
- ile razy nale¿y przesun¹æ ramkê w prawo, aby wyznaczyæ wartoœæ n-tego wyrazu ci¹gu w funkcji seq dla n >= 3 ?
  odp: n-3 razy
*/

/*
- dokonaj analizy wywo³ania seq1(4)

* seq1(4) = 12 
  r1 = 3
  r2 = 4
  r3 = 0
  
  4 == 1  false 
  4 == 2  false 
  
  i
  i = 1
  1 <= 2   r3 = 0.5 * 4 + 2 * 3 = 8   i = 2
           r1 = 4
           r2 = 8 
  2 <= 2   r3 = 0.5 * 8 + 2 * 4 = 12  i = 3
           r1 = 8
           r2 = 12
  3 <= 2   false 
  
  return r3 = 12 

*/

/*
- narysuj graf obliczen dla seq1(4)

	  s(1)    s(2)
        \   /  |
         s(3)  |
            \  |
             s(4)
*/



/*
r1  r2
|---|           n
0   1   2   3   4   5   6    indeksy
1   1   2   3   5   8   13   wartoœci
|   |---|
pom r1  r2

Przesuniêcie ramki w prawo:

pom = r0
r0 = r1
r1 = pom + r0
*/

int seq2(int n) {
    int r1 = 3;
    int r2 = 4;
   
    
    if (n == 1) return r1; 
    if (n == 2) return r2;
   
       int i;
    for (i = 1; i <= n-2; i++) {
        int pom = r1;
        r1 = r2;
           r2 = 0.5 * r1 + 2 * pom;
    }
    
    return r2;
}

/*
- ile razy nale¿y przesun¹æ ramkê w prawo, aby wyznaczyæ wartoœæ n-tego wyrazu ci¹gu w funkcji seq2 dla n >= 2 ?
odp        n-2
*/

/*
- okonaj analizy wywo³ania seq2(4).

* seq2(4) = 12 
  r1 = 3
  r2 = 4

  
  4 == 1  false 
  4 == 2  false 
  
  i
  i = 1
  1 <= 2   pom = 3
           r1 = 4
           r2 = 0.5 * 4 + 2 * 3 = 8   i = 2
      
  2 <= 2   pom = 4  
           r1 = 8
           r2 = 0.5 * 8 + 2 * 4 = 12   i = 3
  3 <= 2   false 
  
  return r2 = 12 

*/

/*

- narysuj graf obliczen dla fibo2(4)

s(1)     s(2)
   \   /  |
    s(3)  |
    |  \  |
    |   s(4)
    |  /
    s(5)
*/
/* 
która funkcja ma mniejsz¹ z³o¿onoœæ obliczeniow¹ seq1 czy seq2 

odp     seq1
*/

int seq3(int n) {
    if (n <= 2) {
        return n + 2;
    } else {
        return 0.5 * seq3(n-1) + 2 * seq3(n-2);
    }
}
/*
- dokonaj analizy wywo³ania seq3(4)

* seq1(4) = 12
  return 0.5 * seq2(3) + 2 * seq (2) =  0.5 * seq2(3) + 2 * seq3(2) = 4 + 8 = 12

* seq2(3) = 8
  return 0.5 * seq3(2) + 2 * seq (1) = 0.5 * seq3(2) + 2 * seq4(1) = 2 + 6 = 8

* seq3(2) = 4
  return n + 2 = 2 + 2 = 4

* seq4(1) = 3
  return n + 2 = 1  + 2 = 3

 */
/*
Analiza do seq3
*/
/*
Graf do seq3
 s(1)   s(2)
  \    /   |
   s(3)    |
  /   \    |
s(2)  s(1) |
  \   /   /
   s(3)  /
  /    \/
s(2)  s(3)
  \   /
   s(4)
 */

void indent(int n) {
    for (int i = 0; i < n; i++) {
        printf("  ");
    }
}

void SequenceTree(int n, int depth) {
    indent(depth);
    printf("seq3(%d)\n", n);

    if (n > 2) {
        SequenceTree(n-1, depth+1);
        SequenceTree(n-2, depth+1);
    }

    indent(depth);
    printf("return seq3(%d) = %d\n", n, seq3(n));
}

int main() {
    printf("sequence.c\n\n");
    
    int n = 4;
    
    printf("seq1(%d) = %d\n", n, seq1(n));
    printf("seq2(%d) = %d\n", n, seq2(n));
    printf("seq3(%d) = %d\n", n, seq3(n));

    printf("SequenceTree for seq3(%d):\n", n);
    SequenceTree(n, 0);

    return 0;
}

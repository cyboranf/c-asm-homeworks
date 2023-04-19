#include <stdio.h>


int main(){
    printf("data.c\n\n");

    int a = 1;
    int b = 2;
    int c;
    int d;
    int e = 3;
    int f;
    int g;
    int h = 4;
        
    int *p_a = &a;
    int *p_b = &b;
    int *p_c = &c;
    int *p_d = &d;
    int *p_e = &e;
    int *p_f = &f;
    int *p_g = &g;
    int *p_h = &h;
    
    printf("&a = %p\n", p_a);
    printf("&b = %p\n", p_b);
    printf("&c = %p\n", p_c);
    printf("&d = %p\n", p_d);
    printf("&e = %p\n", p_e);
    printf("&f = %p\n", p_f);
    printf("&g = %p\n", p_g);
    printf("&h = %p\n", p_h);
    
    printf("\n");
    
    printf("a = %p\n", a);
	printf("b = %p\n", b);
	printf("c = %p\n", c);
	printf("d = %p\n", d);
    printf("e = %p\n", e);
    printf("f = %p\n", f);
    printf("g = %p\n", g);
    printf("h = %p\n", h);

    
    /*
    
    0061FE7C [01][00][00][00]   a
    0061FE78 [02][00][00][00]   b
    0061FE74 [AE][5E][48][77]   c
    0061FE70 [A0][1F][40][00]   d
                         
    0061FE6C [03][00][00][00]   e   
    0061FE68 [00][00][00][00]   f
    0061FE64 [6A][11][40][00]   g
    0061FE60 [04][00][00][00]   h

    */
}

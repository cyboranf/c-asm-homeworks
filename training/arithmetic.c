#include <stdio.h>

int main(int argc, char *argv[]) {
    printf("arithmetic.c\n\n");

    int a = 1;
    int b = 2;
    int c = 3;

    int *p_a = &a;
    int *p_b = &b;
    int *p_c = &c;

    printf("p_a = %p\n", p_a);
    printf("p_b = %p\n", p_b);
    printf("p_c = %p\n\n", p_c);

    /*
    memory map (vertical)

    0061FE90 [01 00 00 00]  a
    0061FE8C [02 00 00 00]  b
    0061FE88 [03 00 00 00]  c

    memory map (horizontal)

    0061FE88     0061FE8C     0061FE90        addresses
    |            |            |
    [03 00 00 00][02 00 00 00][01 00 00 00]   int values
    |            |            |
    p_c          p_b          p_a             pointers
    */

    /* dodawanie i odejmowanie liczby od wskaznika */

    printf("p_a = %p\n", p_b + 1);
    printf("p_b = %p\n", p_b);
    printf("p_c = %p\n\n", p_b - 1);

    /* porównywanie wskazników */

    if (p_a == p_b + 1) printf("p_a == p_b + 1\n");
    if (p_c == p_b - 1) printf("p_c == p_b - 1\n\n");

    /* odejmowanie wskazników */

    printf("p_a - p_b = %d\n", p_a - p_b);
    printf("p_c - p_b = %d\n", p_c - p_b);

    return 0;
}
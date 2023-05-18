#include <stdio.h>

int main() {
    printf("arrays.c\n\n");

    int t[3] = {1, 5, 9};

    printf("sizeof(t) = %lu\n", sizeof(t)); // rozmiar tablicy t
    printf("sizeof(int) = %lu\n", sizeof(int));
    printf("sizeof(t[0]) = %lu\n\n", sizeof(t[0]));

    /* Obliczanie liczby elementow tablicy t */

    printf("liczba elementow t = %lu\n\n", sizeof(t) / sizeof(t[0]));

    /* zmienna t przechowuje adres tablicy elementow typu int */

    printf(" t    = %p\n", t);
    printf("&t    = %p\n", &t);
    printf("&t[0] = %p\n\n", &t[0]);

    /* dostep do komorek tablicy t */

    printf("t[0] = %d\n", t[0]);
    printf("t[1] = %d\n", t[1]);
    printf("t[2] = %d\n\n", t[2]);

    /* wskazniki na komorki tablicy t */

    printf("t   = %p\n", t);
    printf("t+1 = %p\n", t+1);
    printf("t+2 = %p\n\n", t+2);

    /* dostep do komorek tablicy t przez wskazniki */

    printf("*t = %d\n", *t);
    printf("*(t+1) = %d\n", *(t+1));
    printf("*(t+2) = %d\n\n", *(t+2));

    /* dostep do komorek tablicy t przez podanie ich adresow */

    /*
    printf("*((int*)0x23FF34) = %d\n", *((int*)0x23FF34));
    printf("*((int*)0x23FF38) = %d\n", *((int*)0x23FF38));
    printf("*((int*)0x23FF3C) = %d\n\n", *((int*)0x23FF3C));
    */

    /* wyrazenia arytmentyczne z operatorem gwiazdka
       operator gwiazdka wiaze mocniej od operatorow arytmetycznych */

    printf("*t = %d\n", *t);
    printf("*t+1 = %d\n", *t+1);
    printf("*t+2 = %d\n", *t+2);

    /*
    t        t+1      t+2
    |        |        |
    [1 0 0 0][5 0 0 0][9 0 0 0]

    t   -> [1 0 0 0]   *t     = 1   t[0] = 1
    t+1 -> [5 0 0 0]   *(t+1) = 5   t[1] = 5
    t+2 -> [9 0 0 0]   *(t+2) = 9   t[2] = 9
    */

    return 0;
}
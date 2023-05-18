#include <stdio.h>
#include <stdlib.h>

// gcc error.c -o error -m32

void *correct() {
    char *tab = malloc(4 * sizeof(char)); // memory allocated on a heap

    tab[0] = 1;
    tab[1] = 2;
    tab[2] = 3;
    tab[3] = 4;

    return tab; // pointer to memory on a heap
}

void *mistake() {
    char tab[] = {1,2,3,4}; // memory allocated on a stack

    return tab; // pointer to a local variable
}

void printHex(char *p, int n) {
    int i;
    for (i = 0; i < n; i++) {
        printf("%.2X ", *(p + i));
    }

    printf("\n");
}

int main() {
    printf("error.c\n\n");

    void *numbers1 = correct();
    void *numbers2 = mistake();

    printf("\n");

    printHex(numbers1, 4);
    printHex(numbers2, 4);

    free(numbers1);

    return 0;
}

/*
Windows 10
TDM-GCC 4.9.2

linia 38 zakomentowana

error.c

01 02 03 04
01 02 03 04

linia 38 odkomentowana

error.c


01 02 03 04
20 46 11 76

Ubuntu 20.04.5 LTS
gcc 9.4.0

01 02 03 04
Segmentation fault (core dumped)
*/
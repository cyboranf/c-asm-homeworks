#include <stdio.h>

int main() {
    short int value = 0x0102;
    char *ptr = (char *)&value;
    if (*ptr == 0x02) {
        printf("Little-endian architecture\n");
    } else {
        printf("Big-endian architecture\n");
    }
    return 0;
}
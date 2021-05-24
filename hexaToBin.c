char binario[] = "00000000000000000000000000000000";
char hexadecimal[] = "       c8";
char hexachar[] = "0123456789abcdef";
char binarioOrder[] = "0000000100100011010001010110011110001001101010111100110111101111";
                    // "0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111"

#include <string.h>
#include <stdio.h>

void hexaToBin(char *bin, char *hexa, char *charHexa, char *binOrder) {
    int i, j;
    for (i = 0; i < 9; i++) {
        for (j = 0; j < 16; j++) {
            if (hexa[i] == charHexa[j]) {
                printf("%ld ", ((int *)&binOrder[0] + j) - (int *)&binOrder[0]);
                printf("%ld | %s\n", &binOrder[j * 4] - &binOrder[0], &binOrder[j * 4]);
            }
        }
    }
}

int main(void) {
    hexaToBin(binario, hexadecimal, hexachar, binarioOrder);
    printf("%s", binario);
    return 0;
}

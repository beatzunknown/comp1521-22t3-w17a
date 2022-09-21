#include <stdio.h>

int main(void) {
    int x;
    printf("Enter a number: ");
    scanf("%d", &x);

    if (x <= 100 || x >= 1000) {
        printf("small/big\n");
    } else {
        printf("medium\n");
    }
}
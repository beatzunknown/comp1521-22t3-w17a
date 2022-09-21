#include <stdio.h>

int main(void) {
    int x;

    printf("Enter a number: ");
    scanf("%d", &x);

    // our condition is the converse (opposite)
    // so we jump to the false case of our original
    // condition (x > 100 && x < 1000)

    // for the converse, && becomes || and the
    // logical operators (eg: >) all flip

    // the original condition will be false if any
    // of (x > 100) OR (x < 1000) are false
    
    if (x <= 100) goto x_le_100_ge_1000;
    if (x >= 1000) goto x_le_100_ge_1000;

    printf("medium\n");
    goto epilogue;

x_le_100_ge_1000:
    printf("small/big\n");

epilogue:
    return 0;
}

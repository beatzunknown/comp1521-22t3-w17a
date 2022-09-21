#include <stdio.h>
#define SQUARE_MAX 46340

int main(void) {
    int x, y;

    printf("Enter a number: ");
    scanf("%d", &x);

    // our condition is the converse (opposite)
    // so we jump to the false case of our original
    // condition (x > SQUARE_MAX)
    if (x <= SQUARE_MAX) goto x_le_max_val;
    
    printf("square too big for 32 bits\n");
    goto epilogue;
    
x_le_max_val:
    y = x * x;
    printf("%d\n", y);

epilogue:
    return 0;
}

// print a triangle
#include <stdio.h>

int main (void) {
    int i = 1;

loop_i:
    if (i > 10) goto loop_i_end;
    int j = 0;

loop_j:
    if (j >= i) goto loop_j_end;
    printf("*");
    j++;

    goto loop_j;

loop_j_end:
    printf("\n");
    i++;

    goto loop_i;

loop_i_end:
    return 0;
}

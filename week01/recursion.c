#include <stdio.h>

void print_array(int nums[], int i, int len) {
    //for (int i = 0; i < len; i++) {
    //    printf("%d\n", nums[i]);
    //}

    // 1. Exit condition
    if (i == len) {
        return;
    }
    
    // 2. Processing
    printf("%d\n", nums[i]);
    
    // 3. Recursive call
    print_array(nums, i+1, 10);

}

int main(void)
{
    int nums[] = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3};
    print_array(nums, 0, 10);
    
    return 0;
}


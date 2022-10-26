#include <stdio.h>
#include <stdint.h>

uint32_t six_middle_bits(uint32_t u);

int main() {
	printf("Get 6 middle bits of: ");
	
	uint32_t x;
	scanf("%d", &x);

	printf("%d\n", six_middle_bits(x));
}

uint32_t six_middle_bits(uint32_t u) {
	// 0000000000000 111111 0000000000000
	// shift to left by 13
	// 0000000000000 0000000000000 111111 
	// only keep bottom 6 bits
	// so mask of 0b111111 == 0x3F
	// 111111
	return (u >> 13) & 0x3F;
}
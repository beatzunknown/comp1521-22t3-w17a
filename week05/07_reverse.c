#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef unsigned int Word;

Word reverseBits(Word w) {
	Word ret = 0;

	for (int i = 0; i < sizeof(Word)*8; i++) {
		Word check_mask = 1u << i;
		if (w & check_mask) {
			/**
			 * when i is 0
			 * then check_mask is 00000000000000000000000000000001
			 * then set_mask is   10000000000000000000000000000000
			 * 
			 * when i is 1
			 * when check_mask is 00000000000000000000000000000010
			 * then set_mask is   01000000000000000000000000000000
			 * 
			 * when i is 2
			 * when check_mask is 00000000000000000000000000000100
			 * then set_mask is   00100000000000000000000000000000
			 * 
			 * etc etc
			 */
			Word set_mask = 1u << (((sizeof(Word)*8)-1) - i);

			// set the bit at the opposite end
			ret = ret | set_mask;
		}
	}

	return ret;
}

int main(void) {
	// 0000 0001 0010 0011 0100 0101 0110 0111
	Word a = 0x01234567;
	// 1110 0110 1010 0010 1100 0100 1000 0000
	assert(reverseBits(a) == 0xE6A2C480);
	printf("SUCCESS\n");
	return 0;
}
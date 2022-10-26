#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main(int argc, char *argv[]) {
	int16_t num = 30000 + 30000;
	printf("%d\n", num);

	return EXIT_SUCCESS;
}


/** Integer Overflows
 * 
 *  30000 + 30000 = 60000 = -5536
	int16_t range: -2^15 up to 2^15 - 1
				 = -32768 up to 32767
	32767 + 1 = -32768
 */
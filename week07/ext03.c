#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

struct x1 {
    int a;
    float b;
};

union _all {
	int ival;
	char cval;
	char sval[4];
	float fval;
	unsigned int uval;
	struct x1 blah;
};

int main(int argc, char *argv[]) {
	union _all var;
	var.uval = 0x00313233;
	//var.blah.a = 10;

	printf("blah int:\t%d\n", var.blah.a);
	printf("blah float (E):\t%e\n", var.blah.b);

	printf("hex uint:\t%x\n", var.uval); //313233
	printf("dec int:\t%d\n", var.ival); // 3224115
	printf("char:\t\t%c\n", var.cval); // 3
	printf("string:\t\t%s\n", var.sval); // 321
	printf("float:\t\t%f\n", var.fval); // 0.0000
	printf("float (E):\t%e\n", var.fval); // small sub-normal (e-notation)

	return EXIT_SUCCESS;
}

// 0x00 31 32 33

// big endian - 	00 31 32 33
// little endian -	33 32 31 00
// 
// 
// union {
// 	int a;
// 	char b;
// }

// x.a = 1

// 00000000000000000000000000000001

// x.b = 1000900; //0x63

// 01100011000000000000000000000001 - big endian

// 00000000000000000000000001100011 - little endian
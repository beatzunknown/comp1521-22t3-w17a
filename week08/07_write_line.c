#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr,  "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *fp = fopen(argv[1], "w");

    if (fp == NULL) {
        fprintf(stderr, "%s: ", argv[0]);
        perror(argv[1]);
        return 1;
    }

    int c;
    while ((c = fgetc(stdin)) != EOF) {
        fputc(c, fp);

        if (c == '\n') {
            break;
        }
    }    

    fclose(fp);
    
    return 0;
}

/**
 * @brief      This file implements a vulnerable C
 *             application which uses unsanitised
 *             input to retrieve and display the
 *             contents of a specified file.
 *
 * @author     Andrew Timkov
 * @date       2021
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char *argv[]) {
    char cmd[100];
    // system('/bin/cat vuln.c; ls')
    strcpy(cmd, "/bin/cat ");
    strcat(cmd, argv[1]);

    if (system(cmd) != 0) {
        printf("Error!");
    }
    printf("after execution");
    return 0;
}
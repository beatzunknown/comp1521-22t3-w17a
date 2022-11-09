/**
 * @brief      This file implements a slightly safer
 *             version of vuln.c which doesn't allow
 *             direct command injection but still has
 *             unsanitised input.
 *
 * @author     Andrew Timkov
 * @date       2021
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char *argv[]) {
    char *args[] = {"/bin/cat", argv[1], NULL};
    char *envs[] = {NULL};

    if (execve (args[0], args, envs) != 0) {
        printf("Error!");
    }
    printf("after execution");
    return 0;
}
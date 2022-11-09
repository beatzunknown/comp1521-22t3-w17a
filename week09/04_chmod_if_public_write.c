/*
 * This program removes public writeable
 * permissions, if currently available
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

void remove_public_writable(char *pathname);

int main(int argc, char *argv[])
{
    for (int arg = 1; arg < argc; arg++) {
        remove_public_writable(argv[arg]);
    }
    return 0;
}

void remove_public_writable(char *pathname) {
    struct stat metadata;

    if (stat(pathname, &metadata) != 0) {
        perror(pathname);
        exit(1);
    }

    mode_t mode = metadata.st_mode;

    if (!(mode & S_IWOTH)) {
        printf("%s is not publically writable", pathname);
        return;
    }

    printf("removing public write from %s", pathname);

    // new_mode = mode ^ S_IWOTH;
    mode_t new_mode = mode & ~S_IWOTH;

    if (chmod(pathname, new_mode) != 0) {
        perror(pathname);
        exit(1);
    }
    
}
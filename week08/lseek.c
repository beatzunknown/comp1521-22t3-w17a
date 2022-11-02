#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>

int main(int argc, char *argv[])
{    
    char buffer[256];
    int fd = open("lseek.c", O_RDONLY);
    // print at offset 100 from curr (0) - 100
    lseek(fd, 100, SEEK_CUR);
    read(fd, buffer, 40);
    write(1, buffer, 40);
    write(1, "\n\n", 2);

    // print at offset 100 from start - 100
    lseek(fd, 100, SEEK_SET);
    read(fd, buffer, 40);
    write(1, buffer, 40);
    write(1, "\n\n", 2);

    // print at offset -40 from end - 921
    int res = lseek(fd, -40, SEEK_END);
    read(fd, buffer, 40);
    write(1, buffer, 40);
    write(1, "\n\n", 2);

    // print at offset 100 from curr (961) - 1061
    lseek(fd, 100, SEEK_CUR);
    // this is beyond end of file, so 0 bytes are read
    read(fd, buffer, 40);
    // previous contents of buffer are written to stdout
    write(1, buffer, 40);
    write(1, "\n\n", 2);
    return 0;
}
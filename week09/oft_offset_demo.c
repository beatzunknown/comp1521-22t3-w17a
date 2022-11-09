/* 
 * This file demonstrates the concept that the
 * file offset is specific to the open file
 * table, rather than the file descriptor table
 */

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

char buffer[256];

int main(int argc, char *argv[])
{
    int fd = open("oft_offset_demo.c", O_RDONLY);
    fork();
    read(fd, buffer, 20);
    write(1, buffer, 20);
    return 0;
}
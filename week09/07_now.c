/*
 * This executes linux commands through
 * creation of child processes.
 */

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <spawn.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>

extern char **environ;

void spawn_and_wait(char **args) {
    pid_t pid;

    int status = posix_spawn(&pid, args[0], NULL, NULL, args, environ);

    if (status != 0) {
        errno = status;
        perror("posix_spawn failed");
        exit(1);
    }

    if (waitpid(pid, &status, 0) == -1) {
        perror("waitpid failed");
        exit(1);
    }

}

int main(int argc, char *argv[]) {
    spawn_and_wait((char *[]){"/bin/date", "+%d-%m-%Y", NULL});
    spawn_and_wait((char *[]){"/bin/date", "+%T", NULL});
    spawn_and_wait((char *[]){"/usr/bin/whoami", NULL});
    spawn_and_wait((char *[]){"/bin/hostname", "-f", NULL});
    spawn_and_wait((char *[]){"/usr/bin/realpath", ".", NULL});
}
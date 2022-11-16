/*
 * Example of separate I/O threads.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <pthread.h>

void *prompt_thread_run(void *data) {
    while (true) {
        printf("feed me input!\n");
        sleep(1); // sleeps for 1 second
    }

    return NULL;
}

int main(void) {
    pthread_t thread;
    pthread_create(&thread, NULL, prompt_thread_run, NULL);

    char buffer[1024];

    while (fgets(buffer, sizeof(buffer), stdin)) {
        printf("you entered: %s", buffer);
    }

    pthread_cancel(thread);

    return EXIT_SUCCESS;
}

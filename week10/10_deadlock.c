/*
 * Example of deadlock between resources.
 */

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

int add_total = 0;
pthread_mutex_t add_total_mutex = PTHREAD_MUTEX_INITIALIZER;

int sub_total = 10000;
pthread_mutex_t sub_total_mutex = PTHREAD_MUTEX_INITIALIZER;

void *add_then_sub(void *data) {
    for (int i = 0; i < 5000; i++) {
        // sleep for 1 nanosecond
        nanosleep (&(struct timespec){.tv_nsec = 1}, NULL);
        
        // increments add count, then decrements sub count
        pthread_mutex_lock(&add_total_mutex);
        pthread_mutex_lock(&sub_total_mutex);
        add_total++;
        sub_total--;
        pthread_mutex_unlock(&sub_total_mutex);
        pthread_mutex_unlock(&add_total_mutex);
    }

    return NULL;
}

void *sub_then_add(void *data) {
    for (int i = 0; i < 5000; i++) {
        // sleep for 1 nanosecond
        nanosleep (&(struct timespec){.tv_nsec = 1}, NULL);
        
        // decrements sub count, then increments add count
        pthread_mutex_lock(&sub_total_mutex);
        pthread_mutex_lock(&add_total_mutex);
        sub_total--;
        add_total++;
        pthread_mutex_unlock(&add_total_mutex);
        pthread_mutex_unlock(&sub_total_mutex);
    }

    return NULL;
}

int main(void) {
    pthread_t thread1;
    pthread_create(&thread1, NULL, add_then_sub, NULL);

    pthread_t thread2;
    pthread_create(&thread2, NULL, sub_then_add, NULL);

    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);

    // if program works correctly, should print 10000
    printf("Final add total: %d\n", add_total);
    // if program works correctly, should print 0
    printf("Final sub total: %d\n", sub_total);

    return EXIT_SUCCESS;
}

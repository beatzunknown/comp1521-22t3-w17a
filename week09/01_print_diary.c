/*
 * This program reads the contents of "~/.diary"
 * and prints it to stdout.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    char *home_path = getenv("HOME");

    if (home_path == NULL) {
        home_path = ".";
    }

    char *filename = ".diary";

    int diary_path_len = strlen(home_path) + strlen(filename) + 2;
    char diary_path[diary_path_len];

    snprintf(diary_path, diary_path_len, "%s/%s", home_path, filename);

    FILE *fp = fopen(diary_path, "r");

    if (fp == NULL) {
        perror(diary_path);
        return 1;
    }

    int c;
    while ((c = fgetc(fp)) != EOF) {
        fputc(c, stdout);
    }

    fclose(fp);
    
    
    return 0;
}
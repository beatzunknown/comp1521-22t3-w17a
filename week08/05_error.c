#include <err.h>        // for `err(3)', `warn(3)', etc.
#include <errno.h>      // for `errno' values
#include <string.h>     // for `strerror(3)
#include <error.h>

// Retrieve error message and print it manually
errno = ENOENT;
char *error = strerror(errno);
printf("%s", error);    // prints "No such file or directory"

// Standard way to do the above
errno = ENOENT;
perror("");             // prints "No such file or directory"

// Nonstandard way using warn
errno = ENOENT;
warn(NULL);             // prints "<progname>: No such file or directory"

// Nonstandard way  to print error and terminate
errno = ENOENT;
err(1, NULL);           // prints "<progname>: No such file or directory"
                        // and terminates the program with exit code 1.

// GNU C library standard to print error and terminate
error(1, ENOENT, NULL); // prints "<progname>: No such file or directory"
                        // and terminates the program with exit code 1.
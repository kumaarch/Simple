#include <stdio.h>
#include <sys/stat.h>

int main() {
    if (mkdir("myfolder", 0777) == 0)
        printf("Directory created successfully.\n");
    else
        perror("mkdir");  // Shows error if creation fails

    return 0;
}

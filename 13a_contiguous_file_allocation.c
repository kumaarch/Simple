#include <stdio.h>

int main() {
    int disk[20] = {0}; // disk blocks
    int start, length, i, n;

    printf("Number of files: ");
    scanf("%d", &n);

    for (i = 0; i < n; i++) {
        printf("File %d start block and length: ", i+1);
        scanf("%d%d", &start, &length);

        // Check if space is free
        int free = 1;
        for (int j = start; j < start + length; j++)
            if (j >= 20 || disk[j]) free = 0;

        if (free)
            for (int j = start; j < start + length; j++)
                disk[j] = 1;
        else
            printf("Cannot allocate file %d\n", i+1);
    }

    printf("Disk allocation:\n");
    for (i = 0; i < 20; i++) printf("%d ", disk[i]);
    printf("\n");

    return 0;
}

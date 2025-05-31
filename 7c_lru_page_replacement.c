#include <stdio.h>

int main() {
    int pages[] = {1, 2, 3, 2, 4, 1, 5}, n = 7;
    int frames[3] = {-1, -1, -1}, time[3] = {0}, count = 0, faults = 0;
    int i, j, pos, used;

    for (i = 0; i < n; i++) {
        used = 0;

        for (j = 0; j < 3; j++) {
            if (frames[j] == pages[i]) {
                time[j] = ++count;
                used = 1;
                break;
            }
        }

        if (!used) {
            pos = 0;
            for (j = 1; j < 3; j++)
                if (time[j] < time[pos]) pos = j;

            frames[pos] = pages[i];
            time[pos] = ++count;
            faults++;
        }

        printf("Frames: ");
        for (j = 0; j < 3; j++)
            printf("%d ", frames[j]);
        printf("\n");
    }

    printf("Total Page Faults = %d\n", faults);
    return 0;
}

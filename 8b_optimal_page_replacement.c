#include <stdio.h>

int find_optimal(int pages[], int frames[], int n, int index, int f) {
    int i, j, farthest = index, pos = -1, used;

    for (i = 0; i < f; i++) {
        used = 0;
        for (j = index; j < n; j++) {
            if (frames[i] == pages[j]) {
                if (j > farthest) {
                    farthest = j;
                    pos = i;
                }
                used = 1;
                break;
            }
        }
        if (!used) return i;
    }
    return (pos == -1) ? 0 : pos;
}

int main() {
    int pages[] = {1, 2, 3, 4, 1, 2, 5, 1, 2, 3, 4, 5};
    int n = 12, f = 3, frames[3] = {-1, -1, -1}, faults = 0, i, j, hit;

    for (i = 0; i < n; i++) {
        hit = 0;
        for (j = 0; j < f; j++)
            if (frames[j] == pages[i]) hit = 1;

        if (!hit) {
            int pos = -1;
            for (j = 0; j < f; j++)
                if (frames[j] == -1) pos = j;

            if (pos == -1) pos = find_optimal(pages, frames, n, i + 1, f);
            frames[pos] = pages[i];
            faults++;
        }

        printf("Frames: ");
        for (j = 0; j < f; j++) printf("%d ", frames[j]);
        printf("\n");
    }

    printf("Total Page Faults: %d\n", faults);
    return 0;
}

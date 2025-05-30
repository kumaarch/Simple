#include <stdio.h>
#define P 3
#define R 2

int main() {
    int allocation[P][R] = {{1, 0}, {0, 1}, {1, 1}};
    int request[P][R] = {{0, 1}, {1, 0}, {0, 0}};
    int available[R] = {0, 0}, finished[P] = {0};
    int i, j, progress, work[R];

    for (i = 0; i < R; i++) work[i] = available[i];

    do {
        progress = 0;
        for (i = 0; i < P; i++) {
            if (!finished[i]) {
                int canFinish = 1;
                for (j = 0; j < R; j++)
                    if (request[i][j] > work[j]) {
                        canFinish = 0;
                        break;
                    }
                if (canFinish) {
                    for (j = 0; j < R; j++)
                        work[j] += allocation[i][j];
                    finished[i] = 1;
                    progress = 1;
                }
            }
        }
    } while (progress);

    printf("Deadlocked Processes: ");
    int deadlockFound = 0;
    for (i = 0; i < P; i++) {
        if (!finished[i]) {
            printf("P%d ", i);
            deadlockFound = 1;
        }
    }
    if (!deadlockFound) printf("None");
    printf("\n");

    return 0;
}

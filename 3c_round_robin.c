#include <stdio.h>

int main() {
    int bt[3] = {5, 15, 4};  // Burst times
    int rt[3] = {5, 15, 4};  // Remaining times
    int quantum = 4, time = 0, done;

    do {
        done = 1;
        for (int i = 0; i < 3; i++) {
            if (rt[i] > 0) {
                done = 0;
                int t = (rt[i] > quantum) ? quantum : rt[i];
                time += t;
                rt[i] -= t;
                printf("P%d executed for %d units, total time: %d\n", i + 1, t, time);
            }
        }
    } while (!done);

    return 0;
}

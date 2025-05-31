#include <stdio.h>

int main() {
    int blocks[3] = {300, 200, 100};
    int processes[3] = {120, 210, 50};
    int i, j, worst, allocation[3] = {-1, -1, -1};

    for (i = 0; i < 3; i++) {
        worst = -1;
        for (j = 0; j < 3; j++) {
            if (blocks[j] >= processes[i]) {
                if (worst == -1 || blocks[j] > blocks[worst])
                    worst = j;
            }
        }
        if (worst != -1) {
            allocation[i] = worst;
            blocks[worst] -= processes[i];
        }
    }

    for (i = 0; i < 3; i++) {
        printf("Process %d (%d KB) -> ", i+1, processes[i]);
        if (allocation[i] != -1)
            printf("Block %d\n", allocation[i]+1);
        else
            printf("Not Allocated\n");
    }

    return 0;
}

#include <stdio.h>

int main() {
    int bt[] = {10, 5, 8}, pr[] = {2, 1, 3}, i, j, n = 3, temp;
    int p[] = {1, 2, 3};

    for (i = 0; i < n - 1; i++)
        for (j = 0; j < n - 1 - i; j++)
            if (pr[j] > pr[j + 1]) {
                temp = pr[j]; pr[j] = pr[j + 1]; pr[j + 1] = temp;
                temp = bt[j]; bt[j] = bt[j + 1]; bt[j + 1] = temp;
                temp = p[j]; p[j] = p[j + 1]; p[j + 1] = temp;
            }

    int wt = 0;
    printf("P\tBT\tWT\tTAT\n");
    for (i = 0; i < n; i++) {
        printf("P%d\t%d\t%d\t%d\n", p[i], bt[i], wt, wt + bt[i]);
        wt += bt[i];
    }

    return 0;
}

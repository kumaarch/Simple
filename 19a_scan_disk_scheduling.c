#include <stdio.h>
#include <stdlib.h>

int main() {
    int req[] = {95,180,34,119,11,123};
    int n = 6, head = 50, disk_size = 200;
    int i, total = 0;

    // Sort requests
    for(i = 0; i < n-1; i++)
        for(int j = i+1; j < n; j++)
            if(req[i] > req[j]) {
                int t = req[i]; req[i] = req[j]; req[j] = t;
            }

    int start = 0;
    while(start < n && req[start] < head) start++;

    int cur = head;

    // Move up servicing
    for(i = start; i < n; i++) {
        total += abs(req[i] - cur);
        cur = req[i];
        printf("%d ", req[i]);
    }

    // Move to end
    if(cur != disk_size - 1) {
        total += abs((disk_size - 1) - cur);
        cur = disk_size - 1;
    }

    // Move down servicing
    for(i = start - 1; i >= 0; i--) {
        total += abs(req[i] - cur);
        cur = req[i];
        printf("%d ", req[i]);
    }

    printf("\nTotal seek time = %d\n", total);
    return 0;
}

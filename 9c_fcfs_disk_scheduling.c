#include <stdio.h>
#include <stdlib.h>

int main() {
    int n, i, head, seek = 0;

    printf("Enter number of disk requests: ");
    scanf("%d", &n);

    int requests[n];
    printf("Enter disk requests sequence:\n");
    for (i = 0; i < n; i++)
        scanf("%d", &requests[i]);

    printf("Enter initial head position: ");
    scanf("%d", &head);

    for (i = 0; i < n; i++) {
        seek += abs(requests[i] - head);
        head = requests[i];
    }

    printf("Total seek time (distance) = %d\n", seek);
    return 0;
}

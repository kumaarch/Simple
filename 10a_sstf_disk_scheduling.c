#include <stdio.h>
#include <stdlib.h>

int main() {
    int n, head, i, j, closest, distance, total_seek = 0;

    printf("Enter number of disk requests: ");
    scanf("%d", &n);

    int requests[n], visited[n];
    printf("Enter disk requests sequence:\n");
    for(i = 0; i < n; i++) {
        scanf("%d", &requests[i]);
        visited[i] = 0;
    }

    printf("Enter initial head position: ");
    scanf("%d", &head);

    for(i = 0; i < n; i++) {
        closest = -1;
        distance = 1000000;

        for(j = 0; j < n; j++) {
            if (!visited[j]) {
                int diff = abs(head - requests[j]);
                if(diff < distance) {
                    distance = diff;
                    closest = j;
                }
            }
        }

        visited[closest] = 1;
        total_seek += distance;
        head = requests[closest];

        printf("Serviced request: %d\n", requests[closest]);
    }

    printf("Total seek time = %d\n", total_seek);
    return 0;
}

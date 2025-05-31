#include <stdio.h>
#include <stdlib.h>

int main() {
    char domain[100];

    printf("Enter a domain name: ");
    scanf("%s", domain);

    char command[150];
    snprintf(command, sizeof(command), "dig %s", domain);

    printf("\nGetting DNS information for: %s\n\n", domain);
    system(command);

    return 0;
}

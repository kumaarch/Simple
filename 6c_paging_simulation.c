#include <stdio.h>

#define PAGE_SIZE 256

int main() {
    int page_table[4] = {2, 0, 3, 1};
    int logical, page, offset, physical;

    printf("Enter logical address (0-1023): ");
    scanf("%d", &logical);

    page = logical / PAGE_SIZE;
    offset = logical % PAGE_SIZE;
    physical = page_table[page] * PAGE_SIZE + offset;

    printf("Physical address: %d\n", physical);
    return 0;
}

#include <stdio.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <unistd.h>
#include <string.h>

int main() {
    int shmid = shmget(IPC_PRIVATE, 1024, IPC_CREAT | 0666);
    char *shm = (char*) shmat(shmid, NULL, 0);

    if (fork() == 0) {
        sleep(1);
        printf("Child read: %s\n", shm);
        shmdt(shm);
    } else {
        strcpy(shm, "Hello from parent!");
        shmdt(shm);
        wait(NULL);
        shmctl(shmid, IPC_RMID, NULL);
    }

    return 0;
}

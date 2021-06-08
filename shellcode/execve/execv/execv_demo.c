#include <stdio.h>
#include <unistd.h>

int main(){
  printf("여긴 데모: execv\n");
  printf("PID of execv_demo.c is  %d\n", getpid());

  char *args[]= {"./hello", NULL};
  execv(args[0], args);

  printf("Comming back to execv_demo.c\n");
  return 0;

}

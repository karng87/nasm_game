#include<stdio.h>
#include<unistd.h>

int main(){
  printf("\nThe process id is %d\n", getpid());

  pid_t ret_val = fork();
  if(ret_val < 0){
    // fork has failed
    printf("\nFork Failure\n");
  }
  else if(ret_val == 0){
    // child process
    printf("\nChild Process\n");
    printf("The process id is %d\n", getpid());
    sleep(10);
  }
  else{
    // parrent process
    // wait();
    printf("Parent Process\n");
    printf("The process id is %d\n", getpid());
    sleep(20);
  }

  return 0;
}


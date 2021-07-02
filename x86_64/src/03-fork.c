#include<unistd.h>
#include<sys/wait.h>
#include<stdio.h>

int main(){
  pid_t fork_pid, pid_child, pid_parent, pid_first;

  pid_first = getpid();
  printf("first pid: %d\n", pid_first);

  fork_pid = fork();
  if(fork_pid == 0){
    pid_child = getpid();
    printf("child: fork_pid = %d\n", fork_pid);
    printf("child: pid_child= %d\n", pid_child);
  }
  else if(fork_pid> 0){
    pid_parent = getpid();
    printf("root: first_parent = %d\n", pid_first);
    printf("parent: pid_parent = %d\n", pid_parent);
    wait(NULL);
  }
  while(1);
  return 0;
}



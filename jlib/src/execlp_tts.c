#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/wait.h>

int main(){
  int pid = fork();
  if(pid==-1){return 1;}
  if(pid==0){execlp("tts","tts","한글test",NULL);}
  else{wait(NULL);}
  printf("end\n");
  return 0;
}

#include<stdio.h>
#include<unistd.h>

int main(){
  printf ("Hello world\n");
  printf ("PID of hello.c is %d\n", getpid());
  return 0;
}

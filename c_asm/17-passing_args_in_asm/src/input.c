// clang -c input.c
// clang -nopie input.o safeinput.o
// ./a.out
#include <stdio.h>

int safe_input(char *buffer, unsigned length);

int main(){
  char buffer[32];
  printf("your name?"); 
  fflush(stdout);
  safe_input(buffer, 32);
  printf("Pleasure to meet you, %s!\n", buffer);
  return 0;
}

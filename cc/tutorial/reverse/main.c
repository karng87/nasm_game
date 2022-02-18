#include<string.h>
#include<stdio.h>

char *reverse(char* str);

int main(int argc, char** argv){
  printf("%s\n", *(argv+1));
  printf("%s\n", reverse(*(argv+1)));
  return 0;
}

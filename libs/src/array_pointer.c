#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(){
  time_t t;
  srand(time(&t));
  printf("%zu\n",1970+t/60/60/24/365);
  
  int * pi = malloc(4*sizeof(int));
  int ai [4] = {10,11,12,14};
  pi = ai;
  for(int i=0; i<4; i++){
    *(pi+i) = rand()%10;
    printf("%d\n",*(pi+i));
  }
  return 0;
}

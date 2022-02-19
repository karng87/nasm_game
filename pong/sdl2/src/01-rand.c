#include <time.h>
#include <stdlib.h>
#include <stdio.h>

int main(){
  long t ;
  srand(time(&t));
  fprintf(stdout,"time : %ld",t);
  fprintf(stdout,"radom : %d",rand());
  fprintf(stdout,"radom() mod 10 + 1 => %d",rand()%10+1);
  return 0;
}

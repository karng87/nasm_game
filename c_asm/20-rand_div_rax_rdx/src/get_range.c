#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern long random_range(int low, int high);

int main(){

  for(int x=0; x<5; x++){
    printf("%ld\n", random_range(1, 100));
  }

  time_t secs; 
  secs = time(NULL); // time(&secs)
  unsigned int seed = (unsigned)secs;

  srand(seed); // srand(time(NUL>)
  for(int x=0; x<5; x++){
    printf("%ld\n", random_range(1, 100));
  }
  return 0;
}

// https://cs.lmu.edu/~ray/notes/gasexamples/

#include <stdint.h>
#include <stdio.h>
#include <inttypes.h>

int64_t maxOfThree(int64_t, int64_t, int64_t);

int main(){
  printf("%ld\n", maxOfThree(1, -4, -7));
  printf("%ld\n", maxOfThree(2, -6, 1));
  printf("%ld\n", maxOfThree(2, 3, 1));
  printf("%ld\n", maxOfThree(-2, 4, 3));
  printf("%ld\n", maxOfThree(2, -6, 5));
  printf("%ld\n", maxOfThree(2, 4, 6));
  return 0;
}

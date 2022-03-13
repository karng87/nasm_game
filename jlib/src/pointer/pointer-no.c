#include <stdio.h>
int main(){

  int my_int_a;
  printf("%#lx",&my_int_a);

  my_int_a = 1234;
  printf("%#lx",my_int_a);

  printf("%#lx",*&my_int_a);

  return 0;
}

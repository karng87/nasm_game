#include<stdio.h>
#include<unistd.h>

int main(){
  void *first = sbrk(0);
  void *second = sbrk(4090);
  void *third = sbrk(0);

  int * ptr = (int*)third+1;
  *ptr = 0xdead;

  printf("First: %p\n",first);
  printf("Second: %p\n",second);
  printf("Third: %p\n",third);
  return 0;
}

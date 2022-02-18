#include<stdio.h>
void add(int x, int y){
  printf("Addition result = %d\n", x+y);

/**
*  gcc -c -fpic libadd.c
*  gcc -o -shared libmycal.so libadd.o libsub.o
*  ./main
* */
  printf("Ater Added\n");
}

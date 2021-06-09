/*************************************
*
* Heap buffer overflow
* clang -f sanitize=address -g src.c
*
**************************************/
#include<stdlib.h>
#include<stdio.h>
#include<string.h>

int main (){
  char *p = malloc(12);
  //char *p = malloc(14); // memory leak

  //for(int i=0; i<16; i++){
  //  printf("malloc(12): %d\n", *(p+i));
  //}
  memset(p, 'a', 14);
  //memset(p, 'a', 12); // meory lea

  //for(int i=0; i<16; i++){
  //  printf("memset(p, 0, 14): %d\n", *(p+i));
  //}
  return (int)*p;
}

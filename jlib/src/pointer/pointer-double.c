// https://www.geeksforgeeks.org/dynamically-allocate-2d-array-c/
#include <stdio.h>
#include <stdlib.h>
/*
   1 2  3  4
   5 6  7  8
   9 10 11 12

   21 22  23  24
   25 26  27  28
   29 210 211 212

   31 32  33  34
   35 36  37  38
   39 310 311 312
*/
void func2();
int main(){
  func2();
  return 0;
}
void func2(){
  int rows=3, cols=4,count=0;
  int ** pptr;
  printf("before malloc: %p\n",pptr);
  pptr = malloc(3*sizeof(int*));
  printf("after malloc: %p\n",pptr);
  for(int i=0; i<rows;i++){
    *(pptr+i) = malloc(4*sizeof(int));
    for(int j=0;j<cols;j++){
      *(*(pptr+i)+j) = ++count;
    }
  }

  for(int i=0;i<rows;i++){
    printf("%p,\n",*(pptr+i));
    for(int j =0;j<cols;j++){
      printf("%d,",*(*(pptr+i)+j));
    }
    printf("\n");
  }
  for(int i=0;i<rows;i++){
    free(*(pptr+i));
  }
  free(pptr);
}

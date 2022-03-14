#include<stdio.h>
#include<stdlib.h>

int main(){
  int * ptr_n = malloc(4*sizeof(int));
  for(int i=0;i<4;i++){
    *(ptr_n+i) = i;
  }
  ptr_n = realloc(ptr_n,5*sizeof(int));
  for(int i=0;i<16;i++){
    printf("%d,\n",*(ptr_n+i));
  }
  free(ptr_n);
  return 0;
}

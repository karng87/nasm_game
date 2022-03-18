#include<stdio.h>
#include<stdlib.h>

void process(int** arr, int n){
  printf("&arr:%p\t",arr);
  printf("arr:%p\n",*arr);
  for(int i=0;i<n;i++){
    printf("%d\n",*(*arr+i));
  }
  //free(*arr);
}
int main(){
  int a = 10;
  int * arr = malloc(sizeof(int)*8);
  *(arr+7) = a;
  for(int i=0;i<8;i++){
    printf("%d\n",*(arr+i));
  }
  printf("&arr:%p\t",&arr);
  printf("arr:%p\n",arr);
  process(&arr,8);
  free(arr);
  return 0;
}

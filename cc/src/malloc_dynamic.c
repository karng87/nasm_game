#include <stdio.h>
#include <stdlib.h>

int* mal(){
  printf("Enter the number of int pointer: ");
  int n;
  scanf("%d",&n);
  int * ip = (int*)malloc(sizeof(int)*4);
  for(int i = 0; i <4 ; i++){
    *(ip+i) = i;
  }
  for(int i = 0; i<4; i++){
    printf("ip[%d]: %d\n",i,*(ip+i));
  }
  printf("address of ip: %p\n",ip);
  free(ip);
  //ip=NULL;
  return ip;
}

int main(){
  int * mip = mal();
  for(int i = 0; i <4 ; i++){
    *(mip+i) = i;
  }
  for(int i = 0; i<4; i++){
    printf("mip[%d]: %d\n",i,*(mip+i));
  }
  printf("address of mip: %p\n",mip);
  free(mip);
  printf("after free mip => %p\n",mip);
  mip = NULL;
  printf("after mip=NULL; => %p\n",mip);
  return 0;

}

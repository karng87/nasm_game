#include <stdio.h>

void hanoitower(int n, char from, char mid, char to);
int main(){
  hanoitower(3,'A','B','C');
  printf("============\n");
  hanoitower(4,'A','B','C');
  return 0;
}
void hanoitower(int n, char from, char mid, char to){
  if(n==1) {
    printf("%d을 %c에서 %c로 옮긴다\n",n,from,to);
    return;
  }
  hanoitower(n-1,from,to,mid);
  printf("%d를 %c 에서 %c로 옮긴다\n",n,from,to);
  hanoitower(n-1,mid,from,to);
}

/**********************
* f(3,A,B,C){
*     f(2,A,C,B){
*               f(1,A,B,C){1:A->C}
*               2=: A->B
*               f(1,C,A,B){1:C->B}
*     }
*
*     3=:A->C
*
*     f(2,B,A,C){
*               f(1,B,C,A){1=:B->A}
*               2=:B->C
*               f(1,A,B,C){1=:B->C}
*     }
* }
************************/

/************************
* f(4,A,B,C){
*       f(3,A,C,B){}
*       4=:A->C
*       f(3,B,A,C){}
* }
************************/

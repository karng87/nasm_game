#include <stdio.h>

void hanoitower(int n, char from, char mid, char to);
int main(){
  hanoitower(3,'S','W','D');
  return 0;
}
void hanoitower(int n, char start, char waypoint, char dest){
  printf("\n***> entering hanoi(%d,%c,%c,%c) ",n,start,waypoint,dest);
  if(n==0) {
    printf("<*** if return ***\n");
    return;
  }
  printf("-- pass if and <1st> call h(%d,출발점에서 경유지로) ",n-1);
  hanoitower(n-1,start,dest,waypoint);

  printf("\n\t\t%d를 %c 에서 %c로 옮긴다(출발지에서 목적지로)\n",n,start,dest);

  printf("-- <2nd> call h(%d, 경유지에서 목적지로)",n-1);
  hanoitower(n-1,waypoint,start,dest);
  printf("<*** exited hanoi(%d,%c,%c,%c) end return ***\n",n,start,waypoint,dest);
  return;
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

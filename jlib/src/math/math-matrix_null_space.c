#include<stdio.h>
#include<stdlib.h>
void null_space(){
  system("tts Nullspace");
  printf("  Nullspace: Ax = 0 의 해집합으로 모든해를 포함하여 N(A)표기한다.\n");
  printf("           : 이 해집합의 벡터들 x는 R^n에 속한다.\n");
  printf("  nullspace N(A): R^n의 부분공간이다.\n");
  printf("  column space C(A): R^m의 부분공간이다.\n");
  printf("\t A=\\left[ \\begin{array}{}1 & 2 \\\\ 4 & 8 \\end{array} \\right]\n");
}
int main(){
  null_space();
  return 0;
}

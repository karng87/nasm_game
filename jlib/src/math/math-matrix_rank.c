#include<stdio.h>
#include<stdlib.h>
void rank(){
  system("tts rank");
  system("tts pivot");
  printf("  rank: A \\in M_{m,n}(F) s.t rank(A) = dim(R(A)) = dim(C(A)) = rank(A^T)\n");
  printf("  rank: 일차독립인 행 또는 열의 최대 갯수\n");
  printf("  rank: 행열 A의 pivots 의 갯수\n");
  printf("  rank: 행열이 랭크는 그 행열의 열벡터들에 의해 생성된 벡터공간의 차원이다.\n");
}
int main(){
  rank();
  return 0;
}

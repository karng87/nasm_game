#include<stdio.h>
#include<stdlib.h>
void homogeneous(){
  system("tts homogeneous");
  system("tts inhomogeneous");
  printf("  homogenous: Ax = 0\n");
  printf("  inhomogenous: Ax = b\n");
  printf("  : Ax = b의 임이의 해를 s 라 했을때 다음이 항상 성립한다.\n");
  printf("  : s에 Ax=0의 해를 더해도 항상 성립한다.\n");

}
int main(){
  homogeneous();
  return 0;
}

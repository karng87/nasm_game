#include<stdio.h>
#include<stdlib.h>
void elementary_operation(){
  system("tts \"elementary operation\"");
  system("tts \"elementary row operation\"");
  system("tts \"elementary column operation\"");
  system("tts \"row equvalent\"");
  system("tts \"column equvalent\"");
  system("tts \"equvalent equation\"");
  system("tts \"one. reflexive\"");
  system("tts \"two. symmetry\"");
  system("tts \"two. transitive\"");
  system("dic reflexive");
  system("dic symmetry");
  system("dic transitive");
  printf("  elementary operation: 항등행열에 단 1번의 기본행 연산을 적용하여 얻은 행열이다.");
}
int main(){
  elementary_operation();
  return 0;
}

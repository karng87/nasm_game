#include<stdio.h>
#include<stdlib.h>

int main(){
  system("tts \"LHS : left hand side \"");
  system("tts \"RHS : right hand side \"");
  system("tts \"s.t ~ : such that ~을 만족하기를 \"");
  system("tts \"TFAE : the following are equivalent(다음은 동치이다)\"");
  system("tts \"WLOG : without loss of genrality(일반성을 잃지 않고\"");
  system("tts \"Q.E.D. : Quod erat demonstrandum (증명완료)\"");

  system("tts \"Matrix.\"");
  system("tts \"Elementary operation.\"");
  system("tts \"E_{ij}R. : Elimination Matrix (addition instruction) => add i,j*r\"");
  system("tts \"P_{ij}. : Permutaion Matrix (exchange instruction) => echg i,j\"");
  return 0;
}

#include<stdio.h>
#include<stdlib.h>

void set_terms();
int main(){
  set_terms();
  return 0;
}
void set_terms(){
  system("tts \"injective function\"");
  printf("\t단사함수\n");
  system("tts \"surjective function\"");
  printf("\t전사함수\n");
  system("tts \"bijective function\"");
  printf("\t전단사함수\n");
  system("tts \"one to one function\"");
  printf("\t전사함수\n");
  system("tts \"one to one corespendence function\"");
  printf("\t전단사함수\n");
  system("tts \"one to one and onto function\"");
  printf("\t전단사함수\n");
  system("tts \"domain\"");
  printf("\t공역\n");
  system("tts \"range\"");
  printf("\t치역\n");
  system("tts \"image\"");
  printf("\tf(x) 상\n");
  system("tts \"preimage\"");
  printf("\tx 인수\n");
  system("tts \"prof\"");
  system("tts \"suppose\"");
  system("tts \"Q.E.D\"");
}

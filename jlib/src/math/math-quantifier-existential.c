#include<stdio.h>
#include<stdlib.h>

int main(){
  system("tts \"exsistential quantifier: there exsist\"");
  printf("\\exist{x} \\in U");
  printf("\\exist{x} \\in U : U에 속한 어떤 x가 존재해서, 만족하기를");
  printf("\\exist{x} \\in U \\equ p(a_1) v p(a_2) .. v p(a_n)");
  printf("(\\exist{x} \\in A)(p(x)) \\equ \\exist \\in U)(x \\in A ^ p(x)");
  printf("(\\exist{x} \\in A)(p(x)) \\equ (\\exist)(x \\in A ^ p(x)");
  printf("\\forall{x} \\in U \\equ p(a_1) ^ p(a_2) ..^p(a_n)");
  return 0;
}

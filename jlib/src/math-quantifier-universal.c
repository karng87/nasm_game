#include<stdio.h>
#include<stdlib.h>

int main(){
  system("tts \"univeral quantifier: for all\"");
  printf("\\forall{x} \\in U");
  printf("\\forall{x} \\in U : U에 속한 모든 x에 대해서, 임의의 x에 대해서");
  printf("\\forall{x} \\in U \\equ p(a_1) ^ p(a_2) ..^p(a_n)");
  printf("\\exist{x} \\in U \\equ p(a_1) v p(a_2) .. v p(a_n)");
  printf ("~[(\\forall{x})(p(x)) \\equ (\\exist{x})(~p(x))");
  printf ("~[(\\exsist{x})(p(x)) \\equ (\\forall{x})(~p(x))");

  return 0;
}

#include<stdio.h>
#include<stdlib.h>

int main(){
  printf ("~[(\\forall{x})(p(x)) \\equ (\\exist{x})(~p(x))");
  printf ("~[(\\exsist{x})(p(x)) \\equ (\\forall{x})(~p(x))");
  printf ("~ \\equ not");
  printf ("^ \\equ and");
  printf ("v \\equ or");
}

#include<stdio.h>
#include<stdlib.h>


void Levi_Civita_symbol(){
  system("tts \"Levi Civta symbol\"");
  system("tts \"pumutation tensor\"");
  printf("det(AB)= det(A)det(B)\n");
  printf("det(A^{-1})= \\frac{1}{det(A)}\n");
  printf("det(A^{T})= det(A)\n");
  printf("det(A)det(A^{-1}= 1\n");
}
void Kronecker_delta(){
  system("tts \"Kronecker delta\"");
  system("tts \"pumutation tensor\"");
  printf("\\delta_{ij} = \\left{ \\begin{array}{}0 & (i\\neqj)\\\\ 1 & (i\\eqj)\\end{array}\\right .\n");
}
int main(){
  Levi_Civita_symbol();
  Kronecker_delta();
}

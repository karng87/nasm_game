#include<stdio.h>
#include<stdlib.h>

void determinant(){
  printf(" 1) det(I)=1\n");
  printf("det(I_n) = 1\n");
  printf(" 2) alternating\n");
  printf("det\\big(\\vec{r_1},..,\\vec{r_i},..\\vec{r_j},..\\vec{r_n}\\big) = -det\\big(\\vec{r_1},..\\vec{r_j},..\\vec{r_i},..,\\vec{r_n}\\big)\n");
  printf(" 2) multilinearity\n");
  printf("det\\big(..,\\alpha\\vec{r}+\\beta\vec{r'},..\\big) = \\alpha*det\\big(..,\\alpha\\vec{r},..\\big) = \\beta*det\\big(..,\\beta\vec{r'},..\\big)\n");
  printf("|A| = \\epsilon_{\\sigma_1\\sigma_2..\\sigma_n}a_{1\\sigma_1}a_{2\\sigma_2}..a_{n\\sigma_n}\n");
  printf("첫행에서 하나고르면 고른 행의 아래 열 모두 고를수 없다.\n");
  printf("둘째행에서 하나고르면(반드시 첫행에서 고른 열은 제외하고) 고른 행의 아래 열 모두 고를수 없다.\n");
  printf("세째행에서 하나고르면(반드시 첫행 둘째행에서 고른 열은 제외하고) 고른 행의 아래 열 모두 고를수 없다.\n");
  printf("\\sum_{i,j,k}^{3} a_{1,i}a_{2,j}a_{3,k)\n");
}
int main(){
  determinant();
}

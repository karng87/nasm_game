#include<stdio.h>
#include<stdlib.h>
void determinant_manual(){
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
void determinant_tts(){
  system("tts determinant");
  system("tts \"identified matrix\"");
  system("tts multi linearity");
  system("tts alternating");
  system("tts \"elementary row operation\"");
}
void determinant_definition(){
  printf("  determinant: 행열을 인자로 받아 실수값을 리턴하는 함수 이다.\n");
  printf("\t1: 단위행열의 det 는 1 이다\n");
  printf("\t2: multi linerity 하다\n");
  printf("\t3: alternating 하다\n");
  printf("  properties of nxn determinant\n");
  printf("\t1: 행열 A가 zero row 이거나 두개의 같은 행을 가지면 |A|=0 이다.\n");
  printf("\t2: E_{i,j}k (elementary row operation)을 수행한 행열의 행렬식은 변하지 않는다.\n");
  printf("\t : \\because det(E) = det(I_j=I_j+kI_i) => det(..I_i..I_j..) + k*det(..I_i,I_i..)\n");
  printf("\t : \\therefore det(E) = det(I) = 1\n");
  printf("\t : \\therefore det(EA) = det(IA) = det(I)det(A)\n");
  printf("\t : \\det(PA) = (-1)det(A)\n");
  printf("\t : \\because det(E_{ki}) = det(..kI_i..) = k*det(..I_i..)= k\n");
  printf("\t therefore: det(EA) = det(E)*det(A)\n");
  printf("\t therefore: det(BA) = det(B)*det(A)\n");
  printf("\t3: Diagonal matrix(D) det(D)=d_1*d_2..d_n\n");
  printf("\t4: Upper triangular matrix(U) det(PA) = \\pm det(U)d_1*d_2..d_n\n");
  printf("\t4: Upper triangular matrix(U) det(U) = d_1*d_2..d_n\n");
  printf("\t5: Lower triangular matrix(L) det(L) = det(E..I) = det(I) = 1\n");
  printf("\ttherefore: A = LU; det(A) = det(LU) = det(U) ; L := E\n");
  printf("\t6: det(AB)=det(A)det(B), |AB| = |A||B|\n");
  printf("\t7: det(A^T)=det(A)\n");
  printf("\t8: det(A^{-1}) = {det(A)}^{-1} = frac{1}{det(A)} = frac{1}{|A|}\n");
}
int main(){
  determinant_definition();
  determinant_manual();
  determinant_tts();
  return 0;
}

/*
(3,1) (1,2)
det = 5
[ 2/5 -1/5][3 1]
[-1/5  3/5][1 2]

[1  0][3 1] |[1 0]
[0  1][1 2] |[0 1] 

[ 1   0] [3 1]  [ 3         1]
[-1/3 1] [1 2]  [-1+1, -1/3+2]

[ 1   0] [3 1]  [3    1]  E_1: [ 1   0] 
[-1/3 1] [1 2]  [0, 5/3]       [-1/3 1] 

[1 -3/5][ 1   0] [3    0]  E_2: [1 -3/5]
[0    1][-1/3 1] [0, 5/3]       [0    1]

[1 -3/5][ 1   0] [3    0]  E_2: [1 -3/5]
[0    1][-1/3 1] [0, 5/3]       [0    1]

[1+(-3/5)*(-1/3) -3/5] [6/5  -3/5]
[-1/3    1]            [-1/3    1]

[1/3   0] [6/5  -3/5] [1 0]   E_3: [1/3   0]
[0   3/5] [-1/3    1] [0 1]        [0   3/5] 

[1/3 0][6/5  -3/5] = [(1/3)*(6/5) (1/3)*(-3/5)] = [2/5 -1/5]
[0 5/3][-1/3    1] = [(3/5)*(-1/3) 3/5]         = [-1/5 3/5]
*/

/* augmented matrix
[1      0] [3 1]    | [1 0]
[(-1/3) 1] [1 2]    | [0 1] 

[1    0]   [3   1]  | [1      0]
[-1/3 1]   [0 5/3]  | [(-1/3) 1] 

[1 -3/5]  [3   1]  | [1      0]
[0 1]     [0 5/3]  | [(-1/3) 1] 
[1 -3/5]  [3   0]  | [(6/5)  -3/5]
[0 1]     [0 5/3]  | [(-1/3) 1] 

[1/3 0]  [1   0]  | [(2/5)  -1/5]
[0   1]  [0 5/3]  | [(-1/3) 1] 

[1   0] [1 0]  | [(2/5)  -1/5]
[0 3/5] [0 1]  | [(-1/5) 3/5] 
*/

#include<stdio.h>
#include<stdlib.h>
void determinant(){
  system("tts determinant");
  system("tts \"identified matrix\"");
  system("tts multi linearity");
  system("tts alternating");
  system("tts \"elementary row operation\"");
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
  determinant();
  return 0;
}

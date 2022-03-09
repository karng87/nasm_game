#include<stdio.h>
#include<stdlib.h>

int main(){
  system("tts \"harmonic sequence with inverse of arithmetic sequence\"");
  printf("arithmetic sequence of inverse general term   : a_{n} = 1/a_{1} + (n-1)d\n");
  printf("harmonic sequence general term   : H_{n} = \\frac{1}{1/a_{1} + (n-1)d}\n");
  printf("harmonic number      : H_{n} = \\sum_{k=1}^{n}{1/k}\n");
  printf("harmonic recursion   : H_{n} = H_{x} + \\frac{1}{x+1}\n");
  printf("harmonic mean : H mean = (1/b=(1/a + 1/c)/2 := 2/b = 1/a + 1/c) := b = \\frac{2ab}{a+b}\n");
  return 0;
}

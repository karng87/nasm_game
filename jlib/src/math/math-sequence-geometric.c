#include<stdio.h>
#include<stdlib.h>

int main(){
  system("tts \"geometry sequence\"");
  printf("geometry sequence general term   : G_{n} = ar^{n-1}\n");
  printf("geometry series(common ratio=1)  : S_{n} = ar^{n-1}\n");
  printf("geometry series(common ratio!=1) : S_{n} = frac{a(1-r^n)}{1-r}\n");
  printf("geometry mean (b^2=a^2c^2)       : b = \\pm sqrt{ac}\n");
  return 0;
}

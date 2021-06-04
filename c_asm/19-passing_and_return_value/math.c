#include <stdio.h>

int add(int x, int y);
int sub(int x, int y);
int mul(int x, int y);
float div_i(int x, int y);
float div_f(float x, float y);

int main(){
  const int x=5, y=13;
  
  printf("%d + %d = %d\n", x, y, add(x, y));
  printf("%d - %d = %d\n", x, y, sub(x, y));
  printf("%d x %d = %d\n", x, y, mul(x, y));
  printf("%d / %d = %f\n", x, y, div_i(x, y));
  printf("%f / %f = %f\n", (float)x, (float)y, div_f((float)x, (float)y));
  return 0;
}

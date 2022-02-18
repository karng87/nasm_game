#include <stdio.h>

extern int func_i();
extern float func_f();

int main(){
  printf("The value returned from func_i() is 0x%x\n", func_i());
  printf("The value returned from func_f() is %f\n", func_f());
  return 0;
}

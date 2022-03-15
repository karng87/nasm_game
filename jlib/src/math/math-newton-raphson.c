#include<stdio.h>
#include<stdlib.h>
/*
   f(x) = 5x^3 + 4x^2+3x+2

   f(0) = 2 

   f'(x) = 15x^2 + 8x + 3
   f'(0) = 3

   f''(x) = 30x + 8
   f''(0) = 8

   f'''() = 30

   fx = f(0)
*/
void newton_raphson(){
  printf("\t초기치 선택:x_0\n");
  printf("\ttaylor series: f(x)|x=x_0 = f(x_0) + f'(x_0)(x-x_0)+O(h^2) = 0\n");
  printf("\t  => f(x_0) = - f'(x_0)(x-x_0)\n");
  printf("\t  => - f(x_0)/f'(x_0) = (x-x_0)\n");
  printf("\t  => x_0 - f(x_0)/f'(x_0) = x\n");
  printf("\t  => x = x_0 - f(x_0)/f'(x_0)\n");
  printf("\ttaylor series: f(x)가 x=x_0 에서 맞는 근사식이기 때문에 구한 x의 값도 근사값이지만 좀더 실제근에 가까운 Taylor series를 새로 구한 x에 대해서 다시 해본다.\n");
  printf("\t  => 이를 반복하면 실제 근 근처에서 수렴할것이다.\n");
}
int main(){
  newton_raphson();
  return 0;
}

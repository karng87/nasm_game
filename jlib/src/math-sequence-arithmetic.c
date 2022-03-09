#include<stdio.h>

int main(){
  printf("\narithmetic sequence : a_{n} = a_{1} + (n-1)d\n");
  printf("arithmetic series   : frac{n(2a_{a}+(n-1)d)}{2}\n");
}

/* -------------------------
*** arithmetic sequence ***
*----------------------------
 arithmetic sequence : a_{n} = a_1 + (n-1)d
*/

/*------------------------
 *** arithmetic series ***
--------------------------
arithmetic series   : S_{n} = sum_{k=1}^{n}{a_1 + dk -d} = [a_1k + dk^2/2 -dk]_{1}^{n}
   = sum[a_1 + (k-1)d]_{1}^{n}
   = sum[a_1 + kd -d]_{1}^{n}
   = (a_1k + dk^2/2 - dk)
   = (2a_1k + dk^2 - 2dk)/2
   = k(2a_1 + dk - 2d)/2
   = k(2a_1 + (k-2)d)/2
   = k(2a_1 + (k-1)d -d)/2
   = k(2a_1 + (k-1)d)/2 - dk/2
   = n(2a_1 + (n-1)d)/2 - dn/2
*/

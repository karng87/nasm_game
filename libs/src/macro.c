#include <stdio.h>

#define PRINTB(X) printf(#X " is %#lb\n",X);
#define PRINTX(X) printf(#X " is %#lx\n",X);
int main(){
  int a=0b0101;
  int b=0b0111;
  //a^b=0b0010;
  a^=b^=a^=b;
  PRINTB(a)
  PRINTX(b)

  //printf ("H" "ellow\n");
}

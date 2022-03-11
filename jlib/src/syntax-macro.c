#include <stdio.h>
#include <jbits.h>

#define PRINTB(X) jb_i2b(X);
#define PRINTX(X) printf("\n" #X " is %#x\n",X);
int main(){
  int a=0b0101;
  int b=0b0111;
  PRINTB(a)
  PRINTX(b)
  //a^b=0b0010;
  //a ^= b ^= a ^= b;
  jb_swap(&a,&b);
  PRINTB(a)
  PRINTX(b)

  //printf ("H" "ellow\n");
}

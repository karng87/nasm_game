#include <stdio.h>
int main(int i, char ** argv){
  int a = 1111;
  int b = 2222;
  int c = 3333;
  int d = 4444;
  int e = 5555;
  int f = 6666;

  int * pa = &a;
  int * pb = &b;
  int * pi = &d;
  int * pd = &e;
  int * pe = &f;

  int ** ppi;

  // &ppi         : dq pi(:= ppi)
  // &pi(ppi)     : dq &c(:= pi)(:= *ppi)
  // &c(pi)(*ppi) : dd 3333(:= c)(:= *pi)

  printf("===== begin =====\n");
  printf("===== int** ppi; =====\n");
  printf("%%p &ppi: %p\n", &ppi);
  printf("%%p ppi: %p\n", ppi);
  //printf("%%p *ppi: %p\n", *ppi);
  //printf("%%p &ppi: *p\n",**ppi);
  printf("ERROR undeclared id: *ppi & **ppi\n");

  ppi = &pi;
  //(ppi + 1) = &pj ; //Error
  pi = &c;
  //(pi + 1) = &d; // Error

  printf("+++++ ppi=&pi; pi=&c; +++++\n");
  printf("+++++ ppi == &pi +++++\n");
  printf("%%p ppi: %p\n", ppi);
  printf("%%p &pi: %p\n", &pi);
  printf("%%ul ppi: %p\n", ppi);
  printf("%%#xl ppi: %#lx\n", ppi);
  printf("%%p *ppi: %p\n", *ppi);
  printf("%%p pi: %p\n", pi);
  printf("%%p &c: %p\n", &c);
  printf("%%p **ppi: %d\n", **ppi);
  printf("%%p *pi: %d\n", *pi);
  printf("%%p c: %d\n", c);

  printf("=====?? &aa == pi =====\n");
  printf("%%p *(*(&ppi)): %p\n", *(*(&ppi)));

  printf("===== ppi+n =====\n");
  printf("%%p &pa: %p\n", &pa);
  printf("%%p &pb: %p\n", &pb);
  printf("%%p &pi: %p\n", &pi);
  printf("%%p ppi: %p\n", ppi);
  printf("%%p &pd: %p\n", &pd);
  printf("%%p &pe: %p\n", &pe);

  printf("+++++ ppi=&pi; pi=&c; +++++\n");
  printf("%%p ppi-2: %p\n", ppi-2); // minus 는 하자가 있음
  printf("%%p ppi-1: %p\n", ppi-1);
  printf("%%p ppi: %p\n", ppi);
  printf("%%p ppi+1: %p\n", ppi+1);
  printf("%%p ppi+2: %p\n", ppi+2);

  printf("%%p pi-2: %p\n", pi-2); // minus 는 하자가 있음
  printf("%%p pi-1: %p\n", pi-1);
  printf("%%p pi: %p\n", pi);
  printf("%%p pi+1: %p\n", pi+1);
  printf("%%p pi+2: %p\n", pi+2);
  
  printf("%%p *ppi-2: %p\n", *ppi-2);
  printf("%%p *ppi-1: %p\n", *ppi-1);
  printf("%%p *ppi: %p\n", *ppi);
  printf("%%p *ppi+1: %p\n", *ppi+1);
  printf("%%p *ppi+2: %p\n", *ppi+2);

  printf("%%d *(ppi-2): %p\n", *(ppi-2));
  printf("%%d *(ppi-1): %p\n", *(ppi-1));
  printf("%%d *(ppi+0): %p\n", *(ppi+0));
  printf("%%d *(ppi+1): %p\n", *(ppi+1));
  printf("%%d *(ppi+2): %p\n", *(ppi+2));
  **(ppi+3) = 0xabcdefab;
  printf("**(ppi+3) = 0xabcdefab;\n");
  printf("%%d *(ppi+3): %#x\n", **(ppi+1));

  printf("===== &pi+n =====\n");
  printf("%%p &pi: %p\n", &pi);
  printf("%%p &pi+1: %p\n", &pi+1);
  printf("%%p &pi+2: %p\n", &pi+2);
  printf("%%p *(&pi): %p\n", *(&pi));
  printf("%%p *(&pi+1): %p\n", *(&pi+1));
  printf("%%d **(&pi+1): Segment fault 입니다\n");
  return 0;
}

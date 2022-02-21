#include <stdio.h>
int main(int i, char ** argv){
  int a = 1111;
  int b = 2222;
  int c = 3333;
  int d = 4444;
  int e = 5555;
  int f = 6666;

  // &pi: dd (&aa == pi)
  // &aa(pi): dd (0xbbbbbbb==aa)
  int* pi;
  printf("===== begin =====\n");
  printf("===== int* pi; =====\n");
  printf("%%p pi: %p\n", pi);
  printf("%%p &pi: %p\n", &pi);
  printf("ERROR undeclared id: *pi\n");

  pi = &c;
  printf("===== pi = &aa; =====\n");
  printf("===== pi =====\n");
  printf("%%p pi: %p\n", pi);
  printf("%%ul pi: %ul\n", pi);
  printf("%%#x pi: %#x\n", pi);
  printf("=====?? &aa == pi =====\n");
  printf("%%p &c: %p\n", &c);
  printf("%%p c: %d\n", c);
  printf("%%p pi: %p\n", pi);
  printf("%%p *pi: %d\n", *pi);
  printf("%%p &pi: %p\n", &pi);
  printf("===== pi =====\n");
  printf("%%p *(&pi): %p\n", *(&pi));
  printf("%%p &(*pi): %p\n", &(*pi));

  printf("===== *pi = aa =====\n");
  printf("%%p *pi: %d\n", *pi);
  printf("%%p c := %d\n", c);

  printf("===== pi+n =====\n");
  printf("%%p &a: %p\n", &a);
  printf("%%p &b: %p\n", &b);
  printf("%%p &c: %p\n", &c);
  printf("%%p pi: %p\n", pi);
  printf("%%p &pi: %p\n", &pi);
  printf("%%p &d: %p\n", &d);
  printf("%%p &e: %p\n", &e);
  printf("%%p &f: %p\n", &f);
  printf("%%p pi: %p\n", pi);
  printf("%%d *pi: %d\n", *pi);
  printf("%%d &(pi-1): Error cannot take the addr of an rvalue\n");
  printf("%%p pi-1: %p\n", pi-1);
  printf("%%d *(pi-1): %d\n", *(pi-1));
  printf("%%d *(pi-2): %d\n", *(pi-2));
  printf("%%d *(pi+0): %d\n", *(pi+0));
  printf("%%d *(pi+1): %d\n", *(pi+1));
  printf("%%d *(pi+2): %d\n", *(pi+2));
  printf("%%d *(pi+3): %d\n", *(pi+3));
  *(pi+3) = 0xabcdefab;
  printf("*(pi+3) = 0xabcdefab;\n");
  printf("%%d *(pi+3): %#x\n", *(pi+1));

  printf("===== &pi+n =====\n");
  printf("%%p &pi: %p\n", &pi);
  printf("%%p &pi+1: %p\n", &pi+1);
  printf("%%p &pi+2: %p\n", &pi+2);
  printf("%%p *(&pi): %p\n", *(&pi));
  printf("%%p *(&pi+1): %p\n", *(&pi+1));
  printf("%%d **(&pi+1): Segment fault 입니다\n");
  return 0;
}

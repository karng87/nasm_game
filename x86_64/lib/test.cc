// 1) objects for compile
//      gcc -c hello.c world.c
//
// 2) the exeutable file for linking  
//      gcc -shared -o libworld.so world.o
//      gcc -shared -o libhello.so hello.o
//          gcc test.c -lworld -lhello -L.
//
//      gcc -shared -o libhw hello.o world.o 
//
//      r-path for excuting 
//          gcc test.c -lhw -L. -Wl,rpath=.
//
// 3) a excuting for LD_LIRBRRY_PATH
//      LD_LIBARARY_PATH=. ./a.out
//
// ./a.out
//
// gcc test.c hello.o world.o
#include <stdio.h>
#include <iostream>

extern "C" long p_hexadecimal(long x);
extern "C" long p_decimal(long x);
extern "C" void p_newline(void);
int add(int, int);
int sub(int, int);

int main(){
  int a = 9;
  int b = 3;
  long x = 0xabcd'ef12'3456'7890;
  std::cout << p_hexadecimal(x);
  p_newline();
  std::cout << add(a, b);
  p_newline();
  std::cout << sub(a, b);
  p_newline();
  std::cout << p_decimal(x) << std::endl;
  //world();
  return 0;
}

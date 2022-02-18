/**
* gcc -c -fpic add.c
*     add.o
*
* gcc -c -fpic sub.c
*     sub.o
*
* gcc -shared -o libmycal.so add.o sub.o
*     libmycal.so
*
* gcc -c main.c
*     main.o
*
* gcc -o main main.o libmycal.so
* or 
* gcc -o main main.o -L. -lmycal
*     main
*
* **** ./main ;; error
* ldd main ;; check loarder dependencies

***** sudo cp libmycal.so /usr/local/lib
***** or 
***** set LD_LIBRARY_PATH (Link_loaDer Library path)
***** export LD_LIBRARY_PATH=:(path to libmycal.so) 
** ./main ;; OK

*
* ld(Link_LoaDer)
* ldd(Link_LoaDer Dependencies)
* ***/
#include <stdio.h>

void add(int x, int y);
void sub(int x, int y);

int main(){
  int x=10, y=5;
  add(x, y);
  sub(x, y);
  return 0;
}

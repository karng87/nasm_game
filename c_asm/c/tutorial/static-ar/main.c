/**
* gcc -c add.c
**************** gcc -c -pic add.c
* gcc -c sub.c
**************** gcc -c -pic sub.c

* ar rcs libmycal.a *.o
************************ gcc -shared -o libmyacal.so *.o

* gcc -c main.c
******************* gcc -c main.c

* gcc -o main main.o libmycal.o
****************************** gcc -o main main.o libmycal.so
* or
* gcc -o main main.o -L. -lmycal
******************************** the same
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

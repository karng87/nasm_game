#include <stdio.h>
/*
 << 공간 좌표 >>
 1차원 - x축
int * x0;
*(x0...)
 2차원 - x축 y축
int ** xy0;
*[*(xy0+x) + y]
 3차원 - x축 y축 z축
int *** xyz0;
*{[*(xyz0+x) + y] + z} 
*/

int main(){

  char c = 'a';
  printf ("&c : %#lx\n",&c);
  printf ("c : %#x\n",c);
  char* c0 = "abc";
  printf ("&c0 : %#lx\n",&c0);
  printf ("c0 : %#x\n",c0);
  int x = 'a';
  printf ("&x : %#lx\n",&x);
  printf ("x0 : %#x\n",x);
  long l0 = 0x1234567890abcde;
  printf ("&l0 : %#lx\n",&l0);
  printf ("l0 : %#lx\n",l0);

  //(xo+1) = &x2; Error
  int* xo;
  xo = &x;
  printf ("&xo : %#lx\n",&xo);
  printf ("xo : %#lx\n",xo);
  *xo = 01;
  printf ("*xo : %#x\n",*xo);
  //*(xo+1) = 1;
  //*(xo+2) = 2;
  //*(xo+3) = 3;
  //*(xo+4) = 4;
  int** xyo;
  xyo = &xo;
  printf ("&xyo : %#lx\n",&xyo);
  printf ("xyo : %#lx\n",xyo);
  *(*(xyo+0)+0) = 02;
  printf ("*xyo : %#lx\n",*xyo);
  printf ("**xyo : %#x\n",**xyo);
  //*(xyo+1) = &x1;
  //*(xyo+2) = &x2;

  //*(*(xyo+0)+1) = 01;
  //*(*(xyo+0)+2) = 02;
  //*(*(xyo+1)+0) = 10;
  //*(*(xyo+1)+1) = 11;
  //*(*(xyo+1)+2) = 12;

  int*** xyzo;
  xyzo = &xyo;
  printf ("&xyzo : %#lx\n",&xyzo);
  printf ("xyzo : %#lx\n",xyzo);
  *(*(*(xyzo+0)+0)+0) = 03;
  printf ("*xyzo : %#lx\n",*xyzo);
  printf ("**xyzo : %#lx\n",**xyzo);
  printf ("***xyzo : %#x\n",***xyzo);
  //*(*(*(xyzo+1)+0)+0) = 100;
  //*(*(*(xyzo+2)+0)+0) = 200;
  //*(*(*(xyzo+0)+1)+0) = 010;
  //*(*(*(xyzo+0)+0)+1) = 001;
  return 0;
}


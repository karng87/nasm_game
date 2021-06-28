/**
* oprerator priority
* [] > *
* **/
#include <unistd.h>

int main(void){

  char buf[10]= {'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A'};
  write(1, "\n===buf==\n", 10);
  write(1, buf, 10);

  char dbuf[3][10] = {{'0','1','2','3','4','5','6','7','8','9'}, {'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b'}, {'0','1','2','3','4','5','6','7','8','9'}};
  write(1, "\n===dbuf==\n", 11);
  write(1, dbuf, 10);
  write(1, "\n===dbuf01==\n", 13);
  write(1, dbuf[1], 10);
  write(1, "\n===dbuf02==\n", 13);
  write(1, dbuf[2], 10);

  buf[0]='B';
  buf[1]='B';
  buf[9]='B';

  dbuf[2][9] = 'B';

  char *ptr;
  ptr = buf;
  *(ptr+0) = 'p';
  *(ptr) = 'X';
  *(ptr+1) = buf[1];
  *(ptr+2) = dbuf[0][9];
  *(ptr+3) = 'p';
  *(ptr+4) = 'p';
  *(ptr+5) = 'p';
  *(ptr+6) = 'p';
  *(ptr+7) = 'p';
  *(ptr+8) = 'p';
  *(ptr+9) = 'p';
  write(1, "\n===ptr==\n", 10);
  write(1, ptr, 10);

  char **pptr;
  pptr = (char**)dbuf;
  *pptr = buf;
  *(pptr+1) = "PPPPPP";
  *(pptr+2) = "QQQQQr";
  *(pptr+3) = "pptr";
  *((*pptr+3)+3) = 'R';


  write(1, "\n===pptr==\n", 11);
  write(1, *pptr, 10);
  write(1, "\n===pptr01==\n", 13);
  write(1, *(pptr+1), 10);
  write(1, "\n===pptr02==\n", 13);
  write(1, *(pptr+2), 10);
  write(1, "\n===pptr03==\n", 13);
  write(1, *(pptr+3), 4);

  write(1, "\n", 1);
  write(1, "\n=== && Rvalue ==\n", 18);
  write(1, "This Will_ be output to fd #1 that is standard output\n", 10);
}
/**************************************************** 
* Some definitions: 
*   PIC - position independent code (-fPIC) 
*   PIE - position independent executable (-fPIE -pie) 
*   crt - C runtime
*****************************************************

* ***************************************************
* ld tuto.o 
*   -L  /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/ 
*       /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtbegin.o 
*       /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtend.o 
*       /lib/crt1.o 
*       /lib/crti.o 
*       /lib/crtn.o 
*       -dynamic-linker /lib64/ld-linux-x86-64.so.2 
*       -lc
* ***************************************************
*/

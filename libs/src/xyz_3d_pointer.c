#include <stdio.h>


int main(){
  int* str;
  int c1 = 'a';
  int c2 = 'b';
  int c3 = 'c';
/*
 << 공간 좌표 >>
 1차원 - x축
int * str;
*(str+x)
 2차원 - x축 y축
int ** strs;
*[*(strs+x) + y]
 3차원 - x축 y축 z축
int *** strss;
*{[*(strss+x) + y] + z} 
*/
  printf("pointer size %#lx\n",sizeof(int*));
  printf("pointer : %p => %#lx\n",str,str+1);
  printf("&c1: %#lx\t &c2: %p\t c3 : %#lx\n",&c1, &c2,&c3);
  printf("&c2-1: %lx\t &c2: %p\t &c2+1: %#lx\n",&c2-1,&c2,&c2+1);
  str = &c2;
  printf("str-1: %lx\t str: %p\t str+1: %#lx\n",str-1,str,str+1);
  printf("&str-1: %lx\t &str: %p\t &str+1: %#lx\n",&str-1,&str,&str+1);

/*
char * * strs;
&strs: dq => (char) * * (strs) 
(strs...): ------------------->(* strs) 

(*(strs+0)+n): ------------------->(char)
char * * * strss;
&strss: dq => (char *) * * (strss)
*/
  return 0;
}


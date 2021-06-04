// clang -nopie inline.c

#include <stdio.h>

int total;

int main(int argc, char* argv[]){
  int x;
  total = 1;
  for(x=0; x<10; x++){
    printf("%d\n", total);
    asm(
      ".intel_syntax noprefix;"
      ";mov rax, [total];"
      "mov rax, total;"
      "imul rax, 2;"
      "mov total, rax;"
    );
  }
  return 0;
}

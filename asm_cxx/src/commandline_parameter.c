#include <stdio.h>
int main(int argc, char ** argvs){
  /* 
  &argv: dq (argv == [&argv + 0]), 0x...(:= &argv + 1), 0x...(:= &argv + 2)
  argv: dq [argv]  *argv: db 'f','i','r','s','t',0, 's' ....,0
  char * args
    mov byte[arg...], '.'...
      arg: db '.','/','a','.','o','u','t','0' := [arg+n]
    mov byte[arg1...], 'a'...
      arg1: db 's','e'.... := [arg1_n]
  char ** argvs
    mov quad[argvs...], address of arg...
    mov byte[[argvs]+n], 'a'
argvs: dq (&arg) :: *(argvs+0), (&arg1) :: *(argvs+0+1), (&arg2):: *(argvs+0+2) =:[argvs+n]
*(argvs+0) :: arg1: db *(*(argvs+0)+0)::((*(*argv+0+0))), *(*(argv+0) + 1), *((*argvs+0)+1) =:[argvs+n]
*(argvs+1) :: arg2: db *((*argv+1)+0), *((*argv+1)+1), *((*argvs+1)+2) =:[argvs+n]
  */

  
  printf("==== begin ============\n");
  printf("%%p argvs: %p\n", argvs);
  printf("%%p sizeof(argc): %zu\n", sizeof(argc));
  printf("%%p sizeof(argvs): %zu\n", sizeof(argvs));
  printf("%%#lx argv: %#lx\n", argvs);
  printf("%%ul argvs: %ul\n", argvs);
  printf("\n");

  printf("===== << *(argvs...) >> =====\n");
  printf("%%p argvs: %p\n", argvs);
  printf("%%p argvs+1: %p\n", argvs+1);
  printf("%%p *(argvs+0): %p\n", *(argvs+0));
  printf("%%p *(argvs+1): %p\n", *(argvs+1));
  printf("%%p *(argvs+2): %p\n", *(argvs+2));
  printf("\n");

  printf("===== << * ((*argvs) + n) >> =====\n");
  printf("%%c *(*argvs+0): %c\n", *(*argvs+0));
  printf("%%c *(*argvs+1): %c\n", *(*argvs+1));
  printf("%%c *(*argvs+2): %c\n", *(*argvs+2));
  printf("%%c *(*argvs+3): %c\n", *(*argvs+3));
  printf("%%c *(*argvs+4): %c\n", *(*argvs+4));
  printf("%%c *(*argvs+5): %c\n", *(*argvs+5));
  printf("%%c *(*argvs+6): %c\n", *(*argvs+6));
  printf("%%c *(*argvs+7): %c\n", *(*argvs+7));
  printf("%%c *(*argvs+8): %c\n", *(*argvs+8));
  printf("%%c *(*argvs+9): %c\n", *(*argvs+9));
  printf("\n");
  printf("===== << * (*(argvs+1) + n) >> =====\n");
  printf("%%c *(*(argves+1)+0): %c\n", *(*(argvs+1)+0));
  printf("%%c *(*(argves+1)+1): %c\n", *(*(argvs+1)+1));
  printf("%%c *(*(argves+1)+2): %c\n", *(*(argvs+1)+2));
  printf("%%c *(*(argves+1)+3): %c\n", *(*(argvs+1)+3));
  printf("%%c *(*(argves+1)+4): %c\n", *(*(argvs+1)+4));
  printf("%%c *(*(argves+1)+5): %c\n", *(*(argvs+1)+5));
  printf("%%c *(*(argves+1)+6): %c\n", *(*(argvs+1)+6));
  printf("%%c *(*(argves+1)+7): %c\n", *(*(argvs+1)+7));
  printf("%%c *(*(argves+1)+8): %c\n", *(*(argvs+1)+8));
  printf("%%c *(*(argves+1)+9): %c\n", *(*(argvs+1)+9));
  printf("\n");
  printf("===== << *(*(argvs+2)...) >> =====\n");
  printf("%%c *(*(argves+2)+0): %c\n", *(*(argvs+2)+0));
  printf("%%c *(*(argves+2)+1): %c\n", *(*(argvs+2)+1));
  printf("%%c *(*(argves+2)+2): %c\n", *(*(argvs+2)+2));
  printf("%%c *(*(argves+2)+3): %c\n", *(*(argvs+2)+3));
  printf("%%c *(*(argves+2)+4): %c\n", *(*(argvs+2)+4));
  printf("%%c *(*(argves+2)+5): %c\n", *(*(argvs+2)+5));
  printf("%%c *(*(argves+2)+6): %c\n", *(*(argvs+2)+6));
  printf("%%c *(*(argves+2)+7): %c\n", *(*(argvs+2)+7));
  printf("%%c *(*(argves+2)+8): %c\n", *(*(argvs+2)+8));
  printf("%%c *(*(argves+2)+9): %c\n", *(*(argvs+2)+9));
  printf("\n");
  printf("===== << *(*argvs+1)... >> =====\n");
  printf("%%p *(argvs+0): %c\n", *(*argvs+1));
  printf("%%p *(argvs+1)+1: %c\n", *(*argvs+1)+1);
  printf("%%p *(argvs+2)+2: %c\n", *(*argvs+2)+2);
  printf("%%p *(argvs+3)+3: %c\n", *(*argvs+3)+3);
  printf("%%p *(argvs+4)+4: %c\n", *(*argvs+4)+4);
  printf("%%p *(argvs+5)+5: %c\n", *(*argvs+5)+5);
  printf("%%p *(argvs+6)+6: %c\n", *(*argvs+6)+6);
  printf("\n");
  printf("===== << **(argvs+0)... >> =====\n");
  printf("%%p (argvs+0): %p\n", (argvs+0));
  printf("%%p *(*argvs+0)+0: %c\n", *(*argvs));
  printf("%%p *(*argvs+0)+1: %c\n", *(*argvs+1));
  printf("%%p *(*argvs+0)+2: %c\n", *(*argvs+2));
  printf("%%p *(*argvs+0)+3: %c\n", *(*argvs+3));
  printf("%%p *(*argvs+0)+4: %c\n", *(*argvs+4));
  printf("%%p *(*argvs+0)+5: %c\n", *(*argvs+5));
  printf("%%p *(*argvs+0)+6: %c\n", *(*argvs+6));
  printf("%%p *(*argvs+0)+7: %c\n", *(*argvs+7));
  printf("\n");

  printf("===== << *((*argvs + 0) + 0) + n >> =====\n");
  printf("%%p **argvs+0: %c\n", **argvs+0);
  printf("%%p **argvs+1: %c\n", **argvs+1);
  printf("%%p **argvs+2: %d\n", **argvs+2);
  printf("\n");
  printf("===== << *((*argvs + 0) + 1) + n >> =====\n");
  printf("%%p **argvs+0: %c\n", *((*argvs+0)+1)+0);
  printf("%%p **argvs+1: %c\n", **argvs+1);
  printf("%%p **argvs+2: %d\n", **argvs+2);
  printf("\n");

  printf("===== << *(argvs+1) + n >> =====\n");
  printf("%%p **argvs+0: %c\n", **argvs+0);
  printf("%%p **argvs+1: %c\n", **argvs+1);
  printf("%%p **argvs+2: %d\n", **argvs+2);
  printf("\n");

  printf("===== argv + n =====\n");
  printf("%%p argv: %p\n", argvs);
  printf("%%p argvs+1: %p\n", argvs+1);
  printf("%%p argvs+2: %p\n", argvs+2);
  printf("\n");
  printf("===== &argv + n  =====\n");
  printf("%%p &argv: %p\n", &argvs);
  printf("%%p &argvs+1: %p\n", &argvs+1);
  printf("%%p &argvs+2: %p\n", &argvs+2);
  printf("%%p (&argvs+1): %p\n", (&argvs+1));
  printf("%%p (&argvs+2): %p\n", (&argvs+2));
  printf("\n");
  printf("===== *argv + n =====\n");
  printf("%%s *(argvs): %s\n", *(argvs));
  printf("%%s *(argvs+1): %s\n", *(argvs+1));
  printf("%%s *(argvs+2): %s\n", *(argvs+2));
  printf("\n");
  printf("================\n");
  printf("string *(argvs): %s\n", *(argvs));
  printf("string *(argvs+1): %s\n", *(argvs+1));
  printf("string *(argvs+1): %s\n", *(argvs+2));
  printf("================");
  printf("*(argvs+0): %c\n", *(*argvs));
  printf("*(argvs+1): %c\n", *(*argvs+1));
  printf("*(argvs+2): %c\n", *(*argvs+2));
  printf("*(argvs+3): %c\n", *(*argvs+3));
  printf("*(argvs+4): %c\n", *(*argvs+4));
  printf("*(argvs+5): %c\n", *(*argvs+5));
  printf("*(argvs+5): %c\n", *(*argvs+6));
  printf("*(argvs+7): %c\n", *(*argvs+7));
  printf("*(argvs+8): %c\n", *(*argvs+8));

  printf("*(argvs+0): %p\n", *(argvs+0));
  printf("*(argvs+1): %p\n", *(argvs+1));
  printf("*(argvs+2): %p\n", *(argvs+2));
  printf("argv: %p\n", *(argvs+2));
  return 0;
}

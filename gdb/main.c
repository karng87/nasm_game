/*
** breakpoint **
      b func4
   run 
      r first second argvs

** backtrace **
      bt
      bt full

** frame **   
   info frame
   info frame 1

** layout **
   layout next
   tui enable
   tui disable
   refresh
*/
int func4(int x, int y){return 9;}
int func3(int x, int y){int a=3;return func4(a,6);}
void func2(int x,int y){int a;a=func3(4,5);}
void func1(int x,int y){int a=1;func2(3,4);}
int main(int argc, char** argvs){int a;func1(1,2);return 0;}

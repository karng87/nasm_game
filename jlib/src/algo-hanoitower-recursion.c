#include <stdio.h>

void hanoitower(int n, char from, char mid, char to);
int main(){
  hanoitower(3,'S','W','D');
  return 0;
}
void hanoitower(int n, char start, char waypoint, char dest){
  printf("\n***> entering hanoi(%d,%c,%c,%c) ",n,start,waypoint,dest);
  if(n==0) {
    printf("\n<*** <0th :n(%d) void return> ***\n",n);
    return;
  }
  printf("\n\t<1st:n(%d)> call h(%d,출발점(%c), 경유지(%c), 목적지(%c)) --",n,n-1,start,dest,waypoint);
  hanoitower(n-1,start,dest,waypoint);

  printf("\n\t<2nd:n(%d)> Moveing %c ===> %c\t",n,start,dest);

  printf("\n\t<3rd:n(%d)> call h(%d,출발점(%c), 경유지(%c), 목적지(%c)) --",n,n-1,waypoint,start,dest);
  hanoitower(n-1,waypoint,start,dest);
  printf("<*** <4th end call: hanoi(%d,%c,%c,%c) void return\n",n,start,waypoint,dest);
  return;
}

/**********************
  stack {([[{{}}]])}
  점화식 recursion formula

  f_1(s->d) = print(s -> d);
  f_2(s->d) = f_1(s->w);f_1(s->d);
  f_3(s->d) = f_2(s->w);f_1(s->d);f_2(w->d);
  f_4(s->d) = f_3(s->w);f_1(s->d);f_3(w->d);
  f_5(s->d) = f_4(s->w);f_1(s->d);f_4(w->d);
  f_n(s->d) = f_(n-e)(s-w>); f_(1)(s->d); f_{n-1}(w->d);

  f(int n){
    if(n=1){printf;}
    f(n-1);
  }

  void f(n,arg){
    cmd1;
    f(n-1,arg);
    cmd2;
    f(n-2,arg);
    return;
  }
  void f(n,arg){
    if(n==1) printf;return;
    f(n-1,arg){cmd1; f(n-2,arg){}; cmd2; f(n-3,arg){}; return;}
    cmd2;
    f(n-2,arg);
    return;
  }
************************/

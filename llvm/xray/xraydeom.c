/*************************************************************
*
* clang -fxray-instrument -fxray-instruction-threshold=1 -g src.c
*
*  XRAY_OPTIONS=" patch_premain=true xray_mode=xray-basic " ./a.out
*
* llvm-xray account xray-log.a.out.G2dEFI -sort=count -sortorder=dsc -instr_map ./a.out
* llvm-xray stack xray-log.a.out.G2dEFI -instr_map ./a.out
*
* yay -Sy perl-devel-nytprof
*
* llvm-xray stack xray-log.a.out.xjyQ7u -all-stacks -stack-format=flame --aggregation-type=time -instr_map ./a.out | flamegraph.pl > flame.svg
*********************************************************/

#include<unistd.h>
// void func1() __attribute__((xray_always_instrument));
void func1(){
  usleep(10);
}

void func2(int n){
  if(n % 2) func1();
  else usleep(100);
}

int main(){
  for(int i=0; i < 100; ++i){
    func1();
    func2(i);
  }
  return 0;
}

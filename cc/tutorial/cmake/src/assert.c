#include <assert.h>
#include <stdio.h>

int assertTest(int x){
  int a;
  assert(x>10);
  //return(x);
  return x;
}

int main(){
  assertTest(10);
  return 0;
}

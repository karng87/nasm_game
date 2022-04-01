#include <stdio.h>
#include <log/log.h>
#include <flatform/asserts.h>

int main(){
  FATAL("A test msg: %f",3.14f);
  ASSERT(1==0);
  return 0;
}

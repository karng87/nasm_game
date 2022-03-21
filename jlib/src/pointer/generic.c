#include<stdio.h>
#include<stdlib.h>

enum DataType{
  STACK_CHAR,
  STACK_INT,
  STACK_UINT64
};

struct Stack{
  enum DataType type;
  size_t size;
  void* data;
  void* top;
};
struct Stack createStack(size_t size, enum DataType type){
  size_t effectiveSize = 0;
  if(type == STACK_CHAR) effectiveSize = size * sizeof(char);
  else if(type==STACK_INT) effectiveSize = size * sizeof(int);
  else if(type==STACK_UINT64) effectiveSize = size * sizeof(unsigned long long);
  struct Stack s = {
    .type = type,
    .size = size,
    .data = malloc(effectiveSize),
    .top = NULL
  };
  return s;
}
int main(){
  struct Stack s = createStack(10,STACK_INT);
  *((int*)(s.data)+0) = 64;
  s.top = (int*)s.data +0;
  *((int*)(s.data)+1) = 128;
  s.top = (int*)s.data+1;
  free(s.data);
  return 0;
}

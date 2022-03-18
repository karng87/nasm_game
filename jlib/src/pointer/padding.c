#include<stdio.h>
#include<stdlib.h>

//#pragma pack(8)
struct abc{
  char a;
  int b;
  char c;
};
int main(){
  struct abc var;
  printf("struct abc size: %zu\n", sizeof(struct abc));
  printf("var size: %zu", sizeof(var));
  return 0;
}

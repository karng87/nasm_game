#include<stdio.h>
#include<stdlib.h>

struct jidx{int rows; int cols; int** data;};
struct jvec{int cols; double* data;};
struct jmatrix{int rows; int cols; double ** data;};
struct jidx* pset(int n);
void superfor(int f, int n,struct jidx * idx);
int main(){
  struct jidx* idx = pset(4);
  printf("[ ");
  for(int i=0;i<idx->rows;i++){
      printf("[ ");
    for(int j=0; j<idx->cols; j++){
      printf("(%d,%d), ",i,*(*(idx->data + idx->rows)+idx->cols));
    }
      printf("\b\b ]");
  }
  printf(" ]");
  return 0;
}
// 0101100
// 1010100
struct jidx* pset(int n){
  for(int i = 0; i < 1<<n; i++){
  }
}

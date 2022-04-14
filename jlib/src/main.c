#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef unsigned long long u64; 


struct jmatrix{char* name; u64 m; u64 n; u64 stride; void** data;};
struct jidx{u64 n; u64 * index;};
struct jfs{double (**fns)(double,double);};
struct jmatrix* create_matrix(char*,u64,u64,u64,char);
double kronecker_delta(u64,u64);
double epsilon_tensor(struct jidx*);
double det3(struct jmatrix*);
double det4(struct jmatrix*);

int main(){
  struct jmatrix* A;
  A = create_matrix("A",4,4,8,' ');

  printf("Det(A): %lf\n",det4(A));

  for(int i=0;i<A->m;i++) free(*(A->data+i));
  free(A->data);
  free(A);
}

struct jmatrix* create_matrix(char * str,u64 m, u64 n, u64 stride,char type){
  struct jmatrix * A = malloc(sizeof(struct jmatrix));
  A->name = str;
  A->m = m;
  A->n = n;
  A->stride = stride;
  A->data = malloc(sizeof(void*)*A->m);
  printf("%s:(%llu by %llu)\n",A->name,A->m,A->n);
  for(int i=0; i<A->n; i++){
    *(A->data+i) = malloc(A->n * A->stride);
    printf("[ ");
    for(int j=0;j<A->n; j++){
      if(type=='I'){
        *((double*)*(A->data+i)+j) = kronecker_delta(i,j);
      }else if(type=='Z'){
        *((double*)*(A->data+i)+j) = 0.;
      }else{
        *((double*)*(A->data+i)+j) = i*3.+j+1.;
      }
      printf("%lf, ",*((double*)*(A->data+i)+j));
    }
    printf("\b ]\n");
  }
  return A;
}

double kronecker_delta(u64 i, u64 j){
  return i==j?1:0;
}
double epsilon_tensor(struct jidx* idx){
  for(u64 i =0; i< idx->n;i++){
    for(u64 j=i+1;j<idx->n;j++){
      if(*(idx->index+i) == *(idx->index+j)) return 0.;
    }
  }
  int s=0;
  for(u64 i=0; i< idx->n; i++){
    if(*(idx->index+i) != i){
      s++;
      for(u64 j=i+1; j<idx->n; j++){
        if (*(idx->index+j)==i){
          *(idx->index+j) = *(idx->index+i);
        }
      }
    }
  }
  return (s%2)?-1.:1.;
}

double det3(struct jmatrix* A){
  double res=0;
  struct jidx* idx = malloc(sizeof(struct jidx));
  (*idx).n=3;
  (*idx).index  = malloc(sizeof(u64)*3);

  for(u64 i=0; i<(*A).n; i++){
    for(u64 j=0; j<(*A).n; j++){
      for(u64 k=0; k<(*A).n; k++){
        *((*idx).index+0) = i;
        *((*idx).index+1) = j;
        *((*idx).index+2) = k;
        res += epsilon_tensor(idx) * *((double*)*((*A).data+0)+i) * *((double*)*((*A).data+1)+j) * *((double*)*((*A).data +2)+k);
      }
    }
  }
  free((*idx).index);
  free(idx);
  return res;
}
double det4(struct jmatrix* A){
  double res=0;
  struct jidx* idx = malloc(sizeof(struct jidx));
  (*idx).n=(*A).m;
  (*idx).index  = malloc(sizeof(u64)*idx->n);

  for(u64 i=0; i<(*A).n; i++){
    for(u64 j=0; j<(*A).n; j++){
      for(u64 k=0; k<(*A).n; k++){
        for(u64 l=0; l<(*A).n; l++){
          *((*idx).index+0) = i;
          *((*idx).index+1) = j;
          *((*idx).index+2) = k;
          *((*idx).index+3) = l;
          res += epsilon_tensor(idx) * *((double*)*((*A).data+0)+i) * *((double*)*((*A).data+1)+j) * *((double*)*((*A).data +2)+k) * *((double*)*((*A).data +3)+l);
        }
      }
    }
  }
  free((*idx).index);
  free(idx);
  return res;
}

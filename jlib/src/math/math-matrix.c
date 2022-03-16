#include<stdio.h>
#include<stdlib.h>
#include<time.h>
/*
   \hat{e_1} = (2,1) \hat{e_2} = (0,1)
   [2] |0| 1   2
   [1] |1| 1   2
   -----------
   \hat{e_1} = (2,0) \hat{e_2} = (1,1)
   2 1  1   3
   0 1  1   1
   |     *
   |  *  *   *
   --- --- ---
*/
typedef struct matrix{int rows;int cols;double ** data;}matrix;
matrix* create_matrix(int rows,int cols){
  srand(time(0));
  matrix * mat = malloc(sizeof(matrix));
  if(mat ==NULL) {printf("Fail mat");return NULL;}
  mat->rows = rows;
  mat->cols = cols;
  mat->data = malloc(rows * sizeof(double*));
  if(mat ==NULL) {printf("Fail mat->data");return NULL;}
  for(int i=0;i<rows;++i){
    *(mat->data+i) = malloc(cols*sizeof(double));
    if(*(mat->data+i) ==NULL) {printf("Fail *(mat->data+%d)",i);return NULL;}
    for(int j=0;j<cols;j++){
      *(*(mat->data+i)+j) = rand()%10;
    }
  }
  return mat;
}

matrix* mul_matrix(matrix* A,matrix* B){
  /* A_ik * B_kj := AB_ij := \sum_k^n A_ik * B_kj */
  matrix* res = create_matrix(A->rows,B->cols);
  for(int i=0;i<A->rows;++i){
    for(int j=0;j<B->cols;++j){
      *(*(res->data+i)+j)=0;
      for(int k=0;k<A->cols;++k){
       *(*(res->data+i)+j) += *(*(A->data+i)+k) * *(*(B->data+k)+j);
      }
    }
  }
  return res;
}
void free_matrix(matrix* mat){
  for(int i=0;i<mat->rows;++i){free(*(mat->data+i));}
  free(mat->data);
  free(mat);
}

void print_matrix(matrix* mat){
  printf("rows:%d cols:%d data:%p\n",mat->rows,mat->cols,mat->data);
  for(int i=0;i<(mat->rows);++i){
    printf("[ ");
    for(int j=0;j<(mat->cols);++j){
      printf("%lf, ",*(*(mat->data+i)+j));
    }
    printf("\b\b ]\n");
  }
}

int main(){
  //{system("tts \"Elementary operation\"");printf("\tElementary Operaton: 기본행 연산\n");}
  matrix * A = create_matrix(2,2);
  matrix * B = create_matrix(2,1);
  print_matrix(A);
  print_matrix(B);
  matrix * C=mul_matrix(A,B);
  print_matrix(C);

  free_matrix(A);
  free_matrix(B);
  free_matrix(C);
  return 0;
}

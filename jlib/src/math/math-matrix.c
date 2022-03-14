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
  srand(time(NULL));
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
      *(*(mat->data+i)+j) = rand()%20;
    }
  }
  return mat;
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
  matrix * mat = create_matrix(3,3);
  print_matrix(mat);

  free_matrix(mat);
  return 0;
}

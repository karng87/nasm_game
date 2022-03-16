#include<stdio.h>
#include<stdlib.h>
#include<time.h>

typedef struct matrix{int rows;int cols;double ** data;}matrix;

matrix* create_matrix(int,int);
void free_matrix(matrix*);
void print_matrix(matrix*);

matrix* mul_matrix(matrix*,matrix*);
int e_ijk(int,int,int);
void E_k(matrix*,int,int);
void E_p(matrix*,int,int); 
void E_imjk(matrix*,int,int,int);
double det3(matrix*);

int main(){
  //{system("tts \"Elementary operation\"");printf("\tElementary Operaton: 기본행 연산\n");}
  matrix * A = create_matrix(3,3);
  matrix * B = create_matrix(3,1);
  print_matrix(A);
  printf("detA:%lf\n",det3(A));
  //print_matrix(B);
  //matrix * C=mul_matrix(A,B);
  //E_imjk(A,1,2,100);
  //E_k(A,0,100);
  E_p(A,0,1);
  print_matrix(A);

  free_matrix(A);
  free_matrix(B);
  //free_matrix(C);
  return 0;
}
/**
 **/
void E_imjk(matrix* M,int r1,int r2,int k){
  for(int cols=0;cols<M->cols;++cols){
    *(*(M->data+r1)+cols) += k * *(*(M->data+r2)+cols);
  }
}
void E_k(matrix* M, int r, int k){
  for(int cols=0;cols<M->cols;cols++){
    *(*(M->data + r)+cols) *= k;
  }
}
void E_p(matrix* M,int r1,int r2){
  for(int cols=0;cols<M->cols;cols++){
    double d = *(*(M->data+r1)+cols);
    *(*(M->data+r1)+cols) = *(*(M->data+r2)+cols);
    *(*(M->data+r2)+cols) = d;
  }
}
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
      *(*(mat->data+i)+j) = rand()%5;
    }
  }
  return mat;
}
void free_matrix(matrix* mat){
  for(int i=0;i<mat->rows;++i){free(*(mat->data+i));}
  free(mat->data);
  free(mat);
}

int e_ijk(int i, int j, int k){
  if(i==j||j==k||k==i) return 0;
  else if(i+1==j || i-j==2) return 1;
  else return -1;
}

double det3(matrix * M3){
  double det=0;
  for(int i=0; i<3; i++){
    for(int j=0;j<3; j++){
      for(int k=0;k<3;k++){
        int b = e_ijk(i,j,k);
        if(b){
          det += b * *(*(M3->data+0)+i) * *(*(M3->data+1)+j) * *(*(M3->data+2)+k);
        }
      }
    }
  }
  return det;
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

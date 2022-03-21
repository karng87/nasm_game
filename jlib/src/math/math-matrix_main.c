#include<stdio.h>
#include<stdlib.h>
#include<time.h>

double NaN = 0.0/0.0;
double Inf = 1.0/0.0;
double NInf = -1.0/0.0;

typedef struct matrix{int rows;int cols;double** data;}matrix;
typedef struct matrixs{int sizes;int idx;matrix* matrix;}matrixs;
typedef struct idx{int row;int col;}idx;

matrix* create_matrix(int r,int c,double f,int d);
matrix* MI(int n){return create_matrix(n,n,Inf,1);}
matrix* MR(int r,int c){return create_matrix(r,c,Inf,-1);}
matrix* MRR(int r,int c,int d){return create_matrix(r,c,NInf,d);}
matrix* M0(int r,int c){return create_matrix(r,c,0,-1);}
matrix* M1(int r,int c){return create_matrix(r,c,1,-1);}
void free_matrix(matrix*);
void print_matrix(matrix*);

matrix * mul_matrix(matrix*,matrix*);

int e_ijk(int,int,int);
void E_k(matrix*,int,int);
void E_p(matrix*,int,int); 
void EM_bipi(matrix*,idx bi,idx pi,matrixs*);
double det3(matrix*);
int get_non_zero_col(matrix*,int);
void set_MI(matrix*);
void echelon(matrix** M,matrixs*);
int main(){
  //{system("tts \"Elementary operation\"");printf("\tElementary Operaton: 기본행 연산\n");}
  matrixs Es;
  Es.sizes=5;
  Es.idx=0;
  Es.matrix = malloc(sizeof(matrix)*5);
  printf("%d,%d,%p\n",Es.sizes,Es.idx,Es.matrix);
  printf("%d,%d,idx:%p\n",Es.sizes,Es.idx,Es.matrix+Es.idx);
  printf("%d,%d,size-1:%p\n",Es.sizes,Es.idx,Es.matrix+Es.sizes-1);
  for(int i=0;i<Es.sizes;i++){
    printf("Es.matrix+%d: %p\n",i,Es.matrix+i);
    (Es.matrix+i)->cols= 3;
    (Es.matrix+i)->rows= 3;
    set_MI((Es.matrix+i));
  }
  printf(":%p\n", Es.matrix->data);
  /*
  matrix * A = MRR(3,3,10);
  printf("A:\n");
  print_matrix(A);

  echelon(&A,&Es);
  printf("A:\n");
  print_matrix(A);
  free_matrix(A);
  for(int i=0;i<Es.idx;i++) print_matrix(Es.matrix+i);
  for(int i=0;i<Es.idx;i++) free_matrix(Es.matrix+i);
  */
  return 0;
}
/**
 **/
int get_non_zero_col(matrix* M,int row){
    for(int j=0;j<M->cols;j++){
      if(*(*(M->data+row)+j) != 0){
        return j;
      }
    }
  return -1;
}
void EM_bipi(matrix* M, idx below_idx, idx pivot_idx,matrixs* Es){
  /*
     k = [M_{i=~0} / M_{pivot_i,~0j}]
     EM_{i,0}
  */
  double k = *(*(M->data + below_idx.row)+below_idx.col) / *(*(M->data+pivot_idx.row)+pivot_idx.col);
  *(*((Es->matrix+(Es->idx))->data + below_idx.row)+pivot_idx.row) = -k;
  printf("\n** Elementary Matrix(EM) **\n");
  print_matrix(Es->matrix+(Es->idx));
  ++Es->idx;
  printf("----------\n");
}

void echelon(matrix** M,matrixs* Es){
  for(int i=0;i<(*M)->rows-1;i++){
    int c = get_non_zero_col(*M,i);
    if(c==-1) continue;
    idx pi = {i,c};
    for(int b=i+1;b<(*M)->rows;b++){
      idx bi = {b,c};
      if( *(*((*M)->data+b)+c) ==0) continue;
      //*M = EM_bipi(*M,bi,pi);
      EM_bipi(*M,bi,pi,Es);
      matrix * tmp;

      tmp = mul_matrix(Es->matrix+Es->idx-1,*M);
      free_matrix(*M);
      *M = tmp;
      print_matrix(*M);
    }
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

void set_MI(matrix* mat){
  for(int i=0;i<mat->rows;++i){
    for(int j=0;j<mat->cols;j++){
        if(i==j) {*(*(mat->data+i)+j) = 1.;}
        else {*(*(mat->data+i)+j) = 0.;}
    }
  }
}
matrix* create_matrix(int rows,int cols, double data,int d){
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
      if(data==Inf && d == 1){
        if(i==j) {*(*(mat->data+i)+j) = 1.;}
        else {*(*(mat->data+i)+j) = 0.;}
      }
      else if(data==NInf) *(*(mat->data+i)+j) = rand()%d;
      else if(data==Inf) *(*(mat->data+i)+j) = rand();
      else *(*(mat->data+i)+j) = data;
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
  matrix* res = M0(A->rows,B->cols);
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

/*
              (3,5)
   |         *
  4|--*
   |     
   |     
  1|--*  *
   |__|__| __ __ __
      1  2   3

      2,0 1 [2]  2,1 1 [3] 2,1 2 [5]
      0,4 1 [4]  1,4 1 [5] 1,4 1 [6]

      2,0 2 [4]
      0,4 1 [4]

      2,0 3 [6]
      0,4 1 [4]

*/


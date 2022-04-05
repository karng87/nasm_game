#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>

typedef enum TENSOR_NAME {
  Kronecker_Delta = 0,
  Epsilon = 1,
  Diad = 2,
}TENSOR;

typedef struct matrix{int m; int n; double** e;} matrix;
typedef struct matrixs{int n; matrix* matrixs;} matrixs;
typedef struct idx{int n; int* i;}idx;
typedef struct tensor{TENSOR name; double(*func)(idx*); matrixs* matrixs;} tensor;

void create_matrix(matrix*,int,int);
void create_mat(matrix**,int,int);
void print_matrix(matrix*);
void free_matrix(matrix*);
matrix* mul_mat(matrix*,matrix*);

double kronecker_delta(int,int);
double epsilon_ijk(int,int,int);
double kronecker_delta_tensor(idx*);
double epsilon_tensor(idx*);
double determinant(matrix*);
int main(){

  matrix* A;
  A = malloc(sizeof(matrix));
  create_mat(&A,3,3);

  matrix B;
  create_matrix(&B,3,3);

  matrix* C = malloc(sizeof(matrix));
  free(C);
  C = mul_mat(A,&B);

  matrix* D = mul_mat(A,&B);

  print_matrix(A);
  print_matrix(&B);
  print_matrix(C);
  print_matrix(D);
  printf("\nDeterminant of A: %lf\n",determinant(A));
  free_matrix(A);
  free_matrix(&B);
  free_matrix(C);
  free_matrix(D);

  free(A);
  free(C);
  free(D);
}

double determinant(matrix* A){
  double res=0;
  for(int i=0;i<A->m;i++){
      for(int j=0;j<A->m;j++){
        for(int k=0;k<A->n;k++){
          for(int l=0;l<A->n;l++){
            for(int m=0;m<A->n;m++){
              res += epsilon_ijk(i,j,l)*(*(*(A->e+j)+k)) * (*(*(A->e+l)+m));
            }
          }
        }
      }
  }
  return res;
}
matrix* summation_tensor(matrix* A, matrix* B){
  // (AB)_ij = A_ik B_kj
  matrix* C = malloc(sizeof(matrix)*1);
  create_matrix(C, 3, 3);
  for(int i=0;i<A->m;i++){
    for(int j=0;j<A->n;j++){
      for(int l=0;l<B->m;l++){
        *(*(C->e+i)+l) = 0;
        for(int m=0;m<B->n;m++){
          *(*(C->e+i)+l) += kronecker_delta(j,l)*(*(*(A->e+i)+j)) * (*(*(B->e+l)+m));
        }
      }
    printf("\n");
    }
    printf("\n");
  }
  return C;
}

double epsilon_tensor(idx* idx){
  for(int ii=0; ii<idx->n; ii++){
    for(int jj=ii+1; jj<idx->n; jj++){
      if(*((idx->i)+ii)==(*((idx->i)+jj))) return 0.;
    }
  }
  int sum=0;
  for(int ii=0;ii<idx->n;ii++){
    sum += ((*((idx->i)+ii)-ii)>0)?(*((idx->i)+ii)-ii):-(*((idx->i)+ii)-ii);
  }
  return ((sum % 2) % 2 == 0)?1.:-1.;
}

double epsilon_ijk(int i,int j,int k){
  if(i==j || j==k || k==i) return 0.;
  int di = i-1;
  int dj = ((j-2)>0)?j-2:2-j;
  int dk = ((k-3)>0)?k-3:3-k;
  int s = di+dj+dk;
  return ((s%2)%2==0)?1.:-1.;
}
double kronecker_delta_tensor(idx* idx){
  int tmp  = *idx->i;
  for(int ii = 1; ii < idx->n; ii++){
    if(tmp != *idx->i+ii) return 0;
  }
  return 1;
}
double kronecker_delta(int i,int j){
  return (i==j)?1.:0.;
}

void create_mat(matrix** A,int i,int j){
  (*A)->m=i;
  (*A)->n=j;
  (*A)->e = malloc(sizeof(double*) * (*A)->m);
  //for(int i=0;i<A.i;i++) *(A.e+i)=malloc(sizeof(double)*A.j);
  for(int i=0;i<(*A)->m;i++){
    *((*A)->e+i) = malloc(sizeof(double) * ((*A)->n));
    for(int j=0;j<(*A)->n;j++){
      *(*((*A)->e+i)+j) = (double)(i+j);
    }
  }
}
void create_matrix(matrix* A,int i,int j){
  A->m=i;
  A->n=j;
  A->e = malloc(sizeof(double*)*3);
  //for(int i=0;i<A.i;i++) *(A.e+i)=malloc(sizeof(double)*A.j);
  for(int i=0;i<A->m;i++){
    *(A->e+i) = malloc(sizeof(double)*A->n);
    for(int j=0;j<A->n;j++){
      *(*(A->e+i)+j) = (double)(i+j);
    }
  }
}
matrix* mul_mat(matrix* A, matrix* B){
  // (AB)_ij = A_ik B_kj
  matrix* C = malloc(sizeof(matrix)*1);
  create_matrix(C, 3, 3);
  for(int i=0;i<A->m;i++){
    for(int j=0;j<B->n;j++){
      *(*(C->e+i)+j) = 0;
      for(int k=0;k<A->n;k++){
        *(*(C->e+i)+j) += *(*(A->e+i)+k) * (*(*(B->e+k)+j));
        printf("A(%d,%d):%lf, ",i+1,k+1,*(*(A->e+i)+k));
        printf("B(%d,%d):%lf, ",k+1,j+1,*(*(B->e+k)+j));
        printf("C(%d,%d):%lf, ",i+1,j+1,*(*(C->e+i)+j));
      }
    printf("\n");
    }
    printf("\n");
  }
  return C;
}

void print_matrix(matrix* A){
  printf("\n** Matrix M[%d,%d] **\n",A->m,A->n);
  for(int i=0;i<A->m;i++){
    printf("(%d):[ ",i+1);
    for(int j=0;j<A->n;j++){
      printf("(%d):%lf,\t",j+1,*(*(A->e+i)+j));
    }
    printf("\b\b ]\n");
  }
}
void free_matrix(matrix* A){
  for(int i=0;i<A->m;i++){
      free(*(A->e+i));
    }
  free(A->e);
}

#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>
#include<time.h>
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
void create_I(matrix*,int,int);
void create_Z(matrix*,int,int);
void create_R(matrix*,int,int);
void create_mat(matrix**,int,int);

void print_matrix(matrix*);

void free_matrix(matrix*);

matrix* mul_mat(matrix*,matrix*);
matrix* cross_mat(matrix*);

matrix* cross_product(matrix*,matrix*);
double dot_product(matrix*,matrix*);

double kronecker_delta(int,int);
double epsilon_ijk(int,int,int);
double kronecker_delta_tensor(idx*);
double epsilon_tensor(idx*);
double determinant(matrix*);

int main(){
  srand(time(NULL));

  matrix* A;
  A = malloc(sizeof(matrix));
  create_mat(&A,3,3);

  matrix B;
  create_R(&B,3,3);

  matrix* C = malloc(sizeof(matrix));
  free(C);
  C = mul_mat(A,&B);

  matrix* D = mul_mat(A,&B);

  print_matrix(&B);
  print_matrix(C);
  print_matrix(D);
  matrix* E;
  E =cross_mat(&B);
  print_matrix(&B);
  print_matrix(E);
  printf("\nDeterminant of A: %lf\n",determinant(&B));

  free_matrix(A);
  free_matrix(&B);
  free_matrix(C);
  free_matrix(D);
  free_matrix(E);

  free(A);
  free(C);
  free(D);
  free(E);
}

double determinant(matrix* A){
  matrix* M;
  M = cross_mat(A);
  double res=0;
  for(int i=0;i<M->m;i++){
    res+= **(M->e+i);
  }
  free_matrix(M);
  free(M);
  return res;
}

matrix* cross_product(matrix* U, matrix* V){
  matrix* W = malloc(sizeof(matrix));
  create_Z(W,3,1);

  double mr1=0,mr2=0,mr3=0;
  for(int c1=0; c1<W->m; c1++){
    for(int c2=0; c2<U->m; c2++){
      for(int c3=0; c3<V->m; c3++){
        mr1 = 1;
        mr2 = *(*(U->e+1)+c2);
        mr3 = *(*(V->e+2)+c3);
        **(W->e+c1) += epsilon_ijk(c1,c2,c3)*mr1*mr2*mr3;
        //printf("epsilon_ijk(%d,%d,%d): %lf\n",c1,c2,c3,epsilon_ijk(c1,c2,c3));
      }
    }
  }
  return W;
}
matrix* cross_mat(matrix* A){
  matrix* det = malloc(sizeof(matrix));
  create_Z(det,3,1);

  double mr1=0,mr2=0,mr3=0;
  for(int c1=0; c1<A->n; c1++){
    for(int c2=0; c2<A->n; c2++){
      for(int c3=0; c3<A->n; c3++){
        mr1 = *(*(A->e+0)+c1);
        mr2 = *(*(A->e+1)+c2);
        mr3 = *(*(A->e+2)+c3);
        **(det->e+c1) += epsilon_ijk(c1,c2,c3)*mr1*mr2*mr3;
        //printf("epsilon_ijk(%d,%d,%d): %lf\n",c1,c2,c3,epsilon_ijk(c1,c2,c3));
      }
    }
  }
  return det;
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
  for(int i=0;i<idx->n;i++){
    for(int j=i+1;j<idx->n;j++){
      if(*(idx->i+i) == *(idx->i+j)) return 0;
    }
  }
  int flag=0;
  int* buf = malloc(idx->n * sizeof(int));
  for (int i =0;i<idx->n;i++){
    *(buf+i) = *(idx->i+i);
  }
  for(int i=0;i<idx->n;i++){
    if( i+1 == *(buf+i) ) continue;
    for(int j=i;j<idx->n;j++){
      if((i+1) == *(buf+j)){
        *(buf+i) ^= *(buf+j) ^= *(buf+i) ^= *(buf+j);
        flag++;
      }
    }
  }
  free(buf);
  return (flag % 2 == 0)?1.:-1.;
}
double epsilon_ijk(int i,int j,int k){
  if(i==j || j==k || k==i) return 0.;
  int sum=0;
  sum += (i==0)?0:1;
  sum += (j==1)?0:1;
  sum += (k==2)?0:1;
  if(sum==0) return 1;
  // only 3 index
  else return ((sum % 2) == 0)?-1.:1.;
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

void create_Z(matrix* A,int i,int j){
  (A)->m=i;
  (A)->n=j;
  (A)->e = malloc(sizeof(double*) * (A)->m);
  //for(int i=0;i<A.i;i++) *(A.e+i)=malloc(sizeof(double)*A.j);
  for(int i=0;i<(A)->m;i++){
    *((A)->e+i) = malloc(sizeof(double) * ((A)->n));
    for(int j=0;j<(A)->n;j++){
      *(*((A)->e+i)+j) = 0.;
    }
  }
}

void create_R(matrix* A,int i,int j){
  (A)->m=i;
  (A)->n=j;
  (A)->e = malloc(sizeof(double*) * (A)->m);
  //for(int i=0;i<A.i;i++) *(A.e+i)=malloc(sizeof(double)*A.j);
  for(int i=0;i<(A)->m;i++){
    *((A)->e+i) = malloc(sizeof(double) * ((A)->n));
    for(int j=0;j<(A)->n;j++){
      *(*((A)->e+i)+j) = ((double)rand()/RAND_MAX)*2.-1.;
    }
  }
}
void create_I(matrix* A,int i,int j){
  (A)->m=i;
  (A)->n=j;
  (A)->e = malloc(sizeof(double*) * (A)->m);
  //for(int i=0;i<A.i;i++) *(A.e+i)=malloc(sizeof(double)*A.j);
  for(int i=0;i<(A)->m;i++){
    *((A)->e+i) = malloc(sizeof(double) * ((A)->n));
    for(int j=0;j<(A)->n;j++){
      if (i==j) *(*((A)->e+i)+j) = 1.;
      else *(*((A)->e+i)+j) = 0.;
    }
  }
}

void create_mat(matrix** A,int i,int j){
  (*A)->m=i;
  (*A)->n=j;
  (*A)->e = malloc(sizeof(double*) * (*A)->m);
  //for(int i=0;i<A.i;i++) *(A.e+i)=malloc(sizeof(double)*A.j);
  for(int i=0;i<(*A)->m;i++){
    *((*A)->e+i) = malloc(sizeof(double) * ((*A)->n));
    for(int j=0;j<(*A)->n;j++){
      *(*((*A)->e+i)+j) = (double)rand()- (double)RAND_MAX/2;
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
        //printf("A(%d,%d):%lf, ",i+1,k+1,*(*(A->e+i)+k));
        //printf("B(%d,%d):%lf, ",k+1,j+1,*(*(B->e+k)+j));
        //printf("C(%d,%d):%lf, ",i+1,j+1,*(*(C->e+i)+j));
      }
    //printf("\n");
    }
    //printf("\n");
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

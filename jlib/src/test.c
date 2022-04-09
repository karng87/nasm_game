#include<stdio.h>
#include<stdlib.h>

struct matrix{
  int m;
  int n;
  double** data;
};

double e_ijk(int, int, int);
double det(struct matrix*);
int main(){
  struct matrix A;
  A.m = 3;
  A.n =3;
  A.data = malloc(sizeof(double*)*3);
  for(int i=0;i<3;i++){
      *(A.data+i) = malloc(sizeof(double)*3);
    for(int j=0; j<3; j++){
      *(*(A.data+i) +j) = 3*i+j+1;
      printf("A[%d:%d] = %f",i,j,*(*(A.data+i) +j));
    }
  }
  printf("det(A):%f\n",det(&A));
  
  free(*(A.data+0));
  free(*(A.data+1));
  free(*(A.data+2));
  free(A.data);
  return 0;
}

double e_ijk(int i,int j,int k){
  if(i==j || j==k || k==i) return 0;
  else if((i==1&&j==2&&k==3) || (i==2&&j==3&&k==1) || (i==3&&j==1&&k==2)) return 1;
  else return -1;
}

double det(struct matrix * pm){
  double det =0;
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      for(int k=0;k<3;k++){
        det+=e_ijk(i+1,j+1,k+1)* *(*((*pm).data+0)+i) *  *(*((*pm).data+1)+j) * *(*((*pm).data+2)+k);
        printf("det(i:%d,j:%d,k:%d)=%f\n",i+1,j+1,k+1,det);
      }
    }
  }
  return det;
}

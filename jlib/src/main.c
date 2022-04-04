#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <core/log.h>
  
typedef struct idx{int * free; int * dummy;}idx;
typedef struct vec{int dim; double* elm;}vec;
typedef struct matrix{int dim; double* m; double* n;}matrix;

struct orthogonal_basis{double* i;double *j;double *k;};
struct basis{double* x;double *y;double *z;};
struct nabula{double p_over_px;double p_over_py;double p_over_pz;};
struct gradient{double pf_over_px; double pf_over_py; double pf_over_pz;};
struct divergence{double pux_over_px;double puy_over_py;double puz_over_pz;struct vec dot_du;};
struct curl{double p_over_px;double p_over_py;double p_over_pz;struct vec cross_du;};
double dot(struct vec, struct vec);
void create_vec(struct vec*,int);
int main(){
  struct vec v;
    v.dim=3;
    v.e = malloc(3*sizeof(double));
  for(int i=0;i<v.dim;i++){
    *(v.e+i) = (double)(i+1);
    printf("%lf,",*(v.e+i));
  }
  struct vec u;
  create_vec(&u,3);

  printf("%lf,%lf\n",dot(u,v),dot(v,u));
  free(v.e);
  free(u.e);
}

void create_vec(struct vec * v,int dim){
  v->dim=dim,v->e=malloc(dim*sizeof(double));
  srand(time(NULL));
  for(int i=0;i<v->dim;i++){
    *(v->e+i) = (double)(rand());
    printf("%lf,",*(v->e+i));
  }
}

double dot(struct vec v,struct vec u){
  double res=0;
  for(int i=0; i<v.dim; i++){
    res += *(v.e+i) * *(u.e+i);
  }
  return res;
}
double delta_ij(int i, int j){
  return (i==j)?1:0;
}
double epsilon_ijk(int i, int j, int k){
  if(i==j||i==k||j==k) return 0;
  if(i==1){
    return (j==i+1&&k==i+2) ?1 :-1;
  }else if(i==2){
    return (j==i+1&&k==i-1) ?1 :-1;
  }else if(i==3){
    return (j==i-1&&k==i-2) ?1 :-1;
  }else{}
  FATAL("epsilon_ijk indexing error");
}

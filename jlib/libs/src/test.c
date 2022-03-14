#include<stdio.h>
#include<stdlib.h>

struct matrix{
  int rows;
  int cols;
  double ** data;
};
struct matrix* create_matrix(int r, int c){
  struct matrix * mat = malloc(sizeof(struct matrix));
  mat->rows = r;
  mat->cols = c;
  mat->data = malloc(r * sizeof(double*));
  for(int i=0;i<r;++i){*(mat->data+i)=malloc(c*sizeof(double));}
  return mat;
}

void print_matrix(struct matrix* mat){
  for(int i=0;i<mat->rows;++i){
    for(int j=0;j<mat->cols;++j){
      printf("data(%d,%d)=%lf\n",i,j, *(*((mat->data)+i)+j) );
    }
  }
}
int main(){
  struct matrix *mat = create_matrix(3,3);
  print_matrix(mat);
  /*
  <struct mat2 *> mat;
     &mat: <mat2*>mat
        => <mat2>*(mat):: <int<rows>,int<cols>,double**<data>>*(mat)
            => <double**>(*mat).data /iff 
              := <double**> (*mat->data)
              =>  <double*> *((*mat->data)+i)
                => <double> *(*((*mat->data)+i)+j)

            


          
        => <mat2>*(mat+i)
  */
  return 0;
}

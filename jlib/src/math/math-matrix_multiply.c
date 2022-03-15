#include<stdio.h>
#include<stdlib.h>
/*
   \vec{x} = |x_1| \vec{y} = |y_1|
             |x_2|           |y_2|
             |x_3|           |y_3|

  \vec{x}^T = [x_1,x_2,x_3]
  \vec{y}^T = [y_1,y_2,y_3]

  \vec{x}^T * \vec{y}
      [x^1,x^2,x^3] *  |y_1|  =  [x^1 * y_1 + x^2 * y_2 + x_^ * y_3] := 내적
                       |y_2|
                       |y_3|

  \vec{x} * \vec{y}^T
       |x_1|  * [y^1,y^2,y^3] = |(x_1 * y^1), (x_1 * y^2), (x_1 * y^3)| 
       |x_2|                    |(x_2 * y^1), (x_2 * y^2), (x_2 * y^3)|  = (x_i y^j)
       |x_3|                    |(x_3 * y^1), (x_3 * y^2), (x_3 * y^3)| 



   |a,b| |c| = a*c + b*d
         |d|

   |a| |c,d| = |a*c, a*d|
   |b|         |b*c, b*d|
*/
void print_matrix_mul(){
  printf(" \\vec{x} = |x_1| \\vec{y} = |y_1|\n |x_2|           |y_2|\n |x_3|           |y_3|\n \n \\vec{x}^T = [x_1,x_2,x_3]\n \\vec{y}^T = [y_1,y_2,y_3]\n \n \\vec{x}^T * \\vec{y}\n [x^1,x^2,x^3] *  |y_1|  =  [x^1 * y_1 + x^2 * y_2 + x_^ * y_3] := 내적\n |y_2|\n |y_3|\n \n \\vec{x} * \\vec{y}^T\n |x_1|  * [y^1,y^2,y^3] = |(x_1 * y^1), (x_1 * y^2), (x_1 * y^3)| \n |x_2|                    |(x_2 * y^1), (x_2 * y^2), (x_2 * y^3)|  = (x_i y^j)\n |x_3|                    |(x_3 * y^1), (x_3 * y^2), (x_3 * y^3)| \n \n \n \n |a,b| |c| = a*c + b*d\n |d|\n \n |a| |c,d| = |a*c, a*d|\n |b|         |b*c, b*d|\n");
}
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
  print_matrix_mul();
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

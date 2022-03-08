// https://www.geeksforgeeks.org/dynamically-allocate-2d-array-c/
#include <stdio.h>
#include <stdlib.h>
/*
   1 2  3  4
   5 6  7  8
   9 10 11 12

   21 22  23  24
   25 26  27  28
   29 210 211 212

   31 32  33  34
   35 36  37  38
   39 310 311 312
*/
void fun2();
void fun3();

int main(){
  //fun2();
  fun3();
  return 0;
}
void fun3(){
/*
*   1 2  3  4
*   5 6  7  8
*   9 10 11 12
*
*   21 22  23  24
*   25 26  27  28
*   29 29  30, 31
*
*   31 32  33  34
*   35 36  37  38
*   39 40  41  42
*/
  int rows=3,cols=4,depths=3;
  int * ptr = malloc(depths*rows*cols*sizeof(int));
  int count=0;
  for(int i=0;i<depths;i++){
    for(int j=0;j<rows;j++){
      for(int k=0;k<cols;k++){
        *(ptr+(i*rows*cols)+(j*cols)+k) = ++count; 
        //printf("(i=%d,j=%d,k=%d,(i*r*c+j*c+k)=%d,* = %d),",i,j,k,(i*rows*cols+j*cols+k),*(ptr+(i*rows*cols)+(j*cols)+k));
      }
    }
  }
  for(int i=0; i<depths ; i++){
    printf ("\n");
    for(int j=0;j<rows;j++){
      printf ("\n");
      for(int k=0;k<cols;k++){
        printf ("%d,",*(ptr+i*rows*cols+j*cols+k));
      }
    }
  }
  free(ptr);
  ptr=NULL;
}

void fun2(){
/*
   1 2  3  4
   5 6  7  8
   9 10 11 12
*/
  int row = 3;
  int col = 4;
  int* ptr;
  ptr = malloc(row*col*sizeof(int));
  int count = 0;
  for(int i = 0; i < row; i++){
    for(int j = 0; j < col; j++){
     *(ptr+(i*col+j)) = ++count;
    }
  }
  for(int i = 0; i<row*col; i++){
    if((i+1)%4==0)
      printf("%d\n",*(ptr+i));
    else 
      printf("%d,",*(ptr+i));
  }
  free(ptr);
  ptr=NULL;
}

#include<stdlib.h>
#include<stdio.h>
/*
** valgrind **
  valgrind ./a.out
  valgrind --leak-check=full ./a.out
  valgrind --leak-check=full tool=masif ./a.out
  massif-visualizer massif.out...
*/
int main(int argc, char** argvs){
  int ** ptr = malloc(4*sizeof(int*));
  for(int i=0;i<4;i++){
    *(ptr+i) = malloc(3*sizeof(int));
  }
  for(int i=0;i<4;i++){
    for(int j=0;j<3;j++){
      *(*(ptr+i) + j) = i;
    }
  }
  for(int i=0;i<4;i++){
    for(int j=0;j<3;j++){
      printf ("*(ptr+%d)%p => %x\n",j,*(ptr+i)+j,*(*(ptr+i) + j));
    }
  }
}

#include<stdio.h>
#include<stdlib.h>
#include "../include/jbits.h"

int main(){
  int n = 3;
  char*src = malloc(n*sizeof(char));
    for(int i=0;i<n;i++)*(src+i)='A'+i;
    for(int i=0;i<n;i++){if (!*(src+i)) break; printf("%c",*(src+i));}
    printf("\n");

  char**dest =malloc((1<<n) * sizeof(char*));
    for(int i=0;i<(1<<n);i++){ *(dest+i)=malloc(n*sizeof(char)); for(int j=0;j<n;j++)*(*(dest+i)+j)=0; }
    
  jb_powerset(n,src,dest);

  {
   for(int i=0;i<(1<<n);i++){
      printf("(");
      for(int j=0;j<n;j++){
        printf("%c",*(*(dest+i)+j));
        //if((*(*(dest+i)+j))==0)break;
      }
      printf(")\n");
    }
    printf("\n");
  }
  free(src);
  for(int i=0;i<1<<n;i++)free(*(dest+i));
  free(dest);
  return 0;
}

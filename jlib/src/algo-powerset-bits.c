#include<stdio.h>
#include<stdlib.h>

void powersets(char *, int, char**);
void powerset(char *, int, char**);
int main(){
  /*
  int a = 0b001;
  int b = 0b100;
  if(a & b) printf("%d & %d = %d true\n",a,b, a & b);
  else printf("%d & %d = %d false\n",a,b, a & b);
  if(a && b) printf("%d & %d = %d true\n",a,b, a & b);
  else printf("%d & %d = %d false\n",a,b, a & b);
  return 0;
  */
  
  int n = 4;
  char * set = malloc(n);
    for(int i=0;i<n;i++){*(set+i) = 'A'+i;}
  char ** psets = malloc((1<<n) * sizeof(char*));
    for(int i=0;i<(1<<n);i++){ *(psets+i) = malloc(n*sizeof(char)); /*for(int j=0;j<n;j++){*(*(psets+i)+j) = 0;}*/ }
  powerset(set,n,psets);
    for(int i=0;i<(1<<n); i++){
      printf("(");
      for(int j=0;j<n;j++){
        printf("%c",*(*(psets+i)+j));
      }
      printf(")\n");
    }
  free(set);
  for(int i=0;i<(1<<n);i++){
    free(*(psets+i));
  }
  free(psets);
  set=NULL;
  psets=NULL;
  return 0;
}
void powerset(char* set, int n, char**res){
  for(int i=0;i<(1<<n);i++){
    for(int j=0;j<n;j++){
      if(i & 1<<j){
        *(*(res+i)+j) = *(set+j);
      }
    }
  }
}
void powersets(char* set, int n, char**res){
  for(int i=0;i<(1<<n);i++){
    for(int j=0,k=i;k;j++,k >>= 1){
      if(k & 1){
        printf("%c",*(set+j));
        *(*(res+i)+j) = *(set+j);
      }
    }
  }
}
/*
   el_dcba
   0b_0000 = []
   0b_0001 = [a]
   0b_0010 = [b]
   0b_0011 = [a,b]
   0b_0100 = [c]
   0b_0101 = [c,a]
   0b_0110
   0b_0111
   0b_1000
   0b_1001
   0b_1010
   0b_1011
   0b_1100
   0b_1101
   0b_1110
   0b_1111
*/

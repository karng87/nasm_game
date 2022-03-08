#include<stdio.h>
#include<stdlib.h>

void powersets(char *, int, char**);
int main(){
  int n = 3;
  char * set = malloc(n);
  for(int i=0;i<n;i++){*(set+i) = 'A'+i;}
  char ** psets = malloc((1<<n) * sizeof(char*));
  powersets(set,n,psets);
  for(int i=0;i<(1<<n); i++){
    for(int j=0;j<n;j++){
      printf("%c",*(*(psets+i)+j));
    }
    printf("\n");
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
void powersets(char* set, int n, char**res){
  for(int i=0;i<(1<<n);i++){
    char* e =malloc(n);
    //*e = ' ';
    for(int j=0;j<n;j++){
      if(i & (1<<j)){/*printf("%c",*(set+j));*/
        *(e+j) = *(set+j);
      }
    }
    *(res+i) = e;
    e = NULL;
  }
}
/*
   0b_0000
   0b_0001
   0b_0010
   0b_0011
   0b_0100
   0b_0101
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

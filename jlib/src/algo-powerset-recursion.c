#include<stdio.h>
#include<stdlib.h>

const int n = 4;
void pset_rec(char*,int,char**,int);
void jprint(char** pset,int num){
  for(int i=0;i<num;i++){
    printf("\n(");
    for(int j=0;j<n;j++){
      if(*(*(pset+i)+j)==0) break;
      printf("%c",*(*(pset+i)+j));
    }
    printf(")");
  }
  printf("\n");
}

int main(){
  char *set = malloc(n);
  {for(int i=0;i<n;i++){*(set+i)='A'+i;printf("%c ",*(set+i));}}

  char **pset = malloc((1<<n) * sizeof(char*)); 
  for(int i=0;i<(1<<n);i++){(*(pset+i))=malloc(sizeof(char)*n);for(int j=0;j<n;j++) *(*(pset+i)+j)=0;}
  pset_rec(set,n,pset,n);
  jprint(pset,1<<n);
  for(int i=0;i<(1<<n);i++){free (*(pset+i));}
  free(pset);
  free(set);
  return 0;
}

void pset_rec(char* src,int s_size,char** des,int depth){
  if(depth == 0){
    **(des)=0;
    return;
  }
  pset_rec(src, s_size, des, depth-1);

  for(int i=0,d=(1<<depth)/2;i<((1<<depth)/2);i++){
    for(int j=0; j<s_size;j++){
      if(*(*(des+i)+j)==0){
        *(*(des+d)+j) = *(src+depth-1);
        ++d;
        break;
      } 
      *(*(des+d)+j)=*(*(des+i)+j);
    }
  }
}
/*
0     []
1     [][a]
2     [][a][b][ab]
3     [][a][b][ab][c] [ca] [cb] [cab]
  */

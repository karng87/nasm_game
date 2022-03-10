#include<stdio.h>
#include<stdlib.h>

const int n = 3;
void pset_rec(char*,int,int,char**,int);
void jprint(char** pset,int num){for(int i=0;i<num;i++){printf("\n(");for(int j=0;j<n;j++){printf("%c",*(*(pset+i)+j));}printf(")");}printf("\n");}
int main(){
  char*set = malloc(n);
  {for(int i=0;i<n;i++){*(set+i) = 'A'+i;printf("%c ",*(set+i));}}

  char**pset = malloc((1<<n)*sizeof(char*)); 
  for(int i=0;i<(1<<n);i++){*(pset+i)=malloc(sizeof(char*));}//
  pset_rec(set, n,n,pset,n);
  for(int i=0;i<(1<<n);i++){free (*(pset+i));}
  free(pset);
  free(set);
  return 0;
}

void pset_rec(char* src, int s_idx, int s_size, char** des,int depth){
  // *(*des) = ' ','A']
  // *((*des)+1) = ' ','A']
  if(depth == 0){
    char* tmp = malloc(s_size);for(int i=0;i<s_size;i++)*tmp=0;
    *tmp = ' ';*(des)=tmp;
    printf("\ndepth=%d",depth);
    jprint(des,1);
    tmp=NULL;
    return;}
  pset_rec(src, s_size, s_idx, des, depth-1);
  printf("\ndepth=%d",depth);

  for(int i=0,d=(1<<depth)/2;i<=((1<<depth)/2);i++){
    printf("\nstart for (d=%d,i=%d)\t",d,i);
    char* tmp = malloc(s_size);for(int k=0;k<s_size;k++)*tmp=0;
    for(int j=0; j<s_size;j++){
      if(*(*(des+i)+j)==0){*(tmp+j)=*(src+depth-1);*(des+d)= tmp;tmp=NULL;++d;printf("(d:%d,j:%d)\t",d,j);break;} 
      *(tmp+j)=*(*(des+i)+j);
      printf("(j(%d)++.)\t",j);
    }
    printf("end for i(%d)\n",i);
    jprint(des,1<<depth);
  }
}
/*
0     []
1     [][a]
2     [][a][b][ab]
3     [][a][b][ab][c] [ca] [cb] [cab]
  */

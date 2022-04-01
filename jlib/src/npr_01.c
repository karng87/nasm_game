#include <stdio.h>
#include <stdlib.h>
/* DFS
*   depth first search
*/
int factorial(int n){if(n<=1){return 1;}return n*factorial(n-1);}
int inpr(int n, int r){return factorial(n)/(r*factorial(n-r));}
void nPr(char * src, char ** des, int n, int r);
void printp(void * argv,int argc){printf("(");for(int i=0;i<argc;i++){printf("%c,",*(char*)(argv+i));};printf("\b)");}
void printpp(void ** argv,int n,int r){for(int i=0;i<n;i++){printp(*(argv+i),r);}}

int main(){
  const int n=5;
  const int r=3;
  char * src = malloc(n*1); char c =('A'-0); for(int i=0;i<n;i++){*(src+i)=c++;}
  char ** des = malloc(inpr(n,r)*sizeof(char*)); for(int i=0;i<inpr(n,3);i++){*(des+i)=malloc(r*1);}
  nPr(src,des,n,3);
  printpp((void*)des,inpr(5,3),3);
  return 0;
}

void nPr(char * src, char ** des, int n, int r){
  //if(n==r){return;}
  //static int cnt=0;
  printf("5p3=%d\n",inpr(n,r));
  printf("5p1=%d\n",inpr(5,1));
  for(int i=0;i<inpr(n,r);i++){
    for(int j=0;j<r;j++){
      *(*(des+i)+j) = *(src+j);
    }
  }
}


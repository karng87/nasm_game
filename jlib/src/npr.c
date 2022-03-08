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
  const int n=3;
  const int r=3;
  char * src = malloc(n*1); char c =('A'-0); for(int i=0;i<n;i++){*(src+i)=c++;}
  char ** des = malloc(inpr(n,r)*sizeof(char*)); for(int i=0;i<inpr(n,3);i++){*(des+i)=malloc(r*1);}
  nPr(src,des,n,0);
  printpp(des,inpr(n,r),3);
  return 0;
}

void nPr(char * src, char ** des, int n, int si){
  static int sgi = 0;
  if(si==1){for(int i=0;i<n;i++){*(*(des+sgi)+i) = *(src+i);}sgi++;return;}
  for(int i=si;i<n;i++){
    if(i!=si)*(src+si)^=*(src+i)^=*(src+si)^=*(src+i);
    nPr(src,des,n,si++);
    if(i!=si)*(src+si)^=*(src+i)^=*(src+si)^=*(src+i);
  }
}


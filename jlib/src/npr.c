#include <stdio.h>
#include <stdlib.h>
/* DFS
*   depth first search
*/
int factorial(int n){if(n<=1){return 1;}return n*factorial(n-1);}
int inpr(int n, int r){return factorial(n)/(r*factorial(n-r));}
void nPr(char * src, char ** des, int n, int r);
void printp(char * argv,int argc){printf("(");for(int i=0;i<argc;i++){printf("%c,",*(char*)(argv+i));};printf("\b)");}
void printpp(char ** argv,int n,int r){for(int i=0;i<n;i++){printp(*(argv+i),r);}}

int main(){
  const int n=3;
  const int r=1;
  char * src = malloc(n*sizeof(char)); char c =('A'-0); for(int i=0;i<n;i++){*(src+i)=c++;}
  char ** dest = malloc(inpr(n,r)*sizeof(char*)); for(int i=0;i<inpr(n,r);i++){*(dest+i)=malloc(r*sizeof(char));}
  nPr(src,dest,n,0);
  printpp(dest,inpr(n,r),3);
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


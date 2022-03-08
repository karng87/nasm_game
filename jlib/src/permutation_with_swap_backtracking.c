#include <stdio.h>
#include <stdlib.h>
void factorial(int n);
void printsrc(char * src, int n){
  printf("(");
  for(int i = 0; i<n; i++){
    if(i==n-1) printf("%c)",*(src+i));
    else printf("%c,",*(src+i));
  }
}

void npn(char * src, int n);
void npr(char * src, int n, int i);

int main(){
  char * src = malloc(4);
  *src = 'A';
  *(src+1) = 'B';
  *(src+2) = 'C';
  *(src+3) = 'D';
  npn(src,3);
  free(src);
  return 0;
}
void npn(char * src, int n){
  npr(src,n,0);
}
void npr(char *src, int n, int si){
  if(si==n){
    printsrc(src,3);
    printf("  ");
    return;
  }
  for(int i=si;i<n;i++){
    //printf ("(swap %d -> %d)\t",si,i);
    if(i!=si)(*(src+si) ^= *(src+i) ^= *(src+si) ^= *(src+i));
    npr(src,n,si+1);
    if(i!=si)(*(src+si) ^= *(src+i) ^= *(src+si) ^= *(src+i));
    //printsrc (src,4);
  } 
}

/*
 (n=3,si=0,i=0) (n=3,si=1,i=1) (n=3,si=2,i=2) (1) (n=3,si=1,i=2) (n=3,si=2,i=2) (1)
 (n=3,si=0,i=1) (n=3,si=1,i=1) (n=3,si=2,i=2) (1) (n=3,si=1,i=2) (n=3,si=2,i=2) (1)
 (n=3,si=0,i=2) (n=3,si=1,i=1) (n=3,si=2,i=2) (1) (n=3,si=1,i=2) (n=3,si=2,i=2) (1)
*/
/*********************
void factorial(int n){
  if(n==1){
    printf("(1)");
    return;
  }
  for(int i=0;i<n;i++){
    printf ("(n=%d,i=%d) ",n,i);
    factorial(n-1);
  }
}
*******************/
/******************
(n=4,i=0) (n=3,i=0) (n=2,i=0) (1)
                    (n=2,i=1) (1)
          (n=3,i=1) (n=2,i=0) (1)
                    (n=2,i=1) (1)
          (n=3,i=2) (n=2,i=0) (1)
                    (n=2,i=1) (1)
(n=4,i=1) (n=3,i=0) (n=2,i=0) (1)
                    (n=2,i=1) (1)
          (n=3,i=1) (n=2,i=0) (1)
                    (n=2,i=1) (1)
          (n=3,i=2) (n=2,i=0) (1)
                    (n=2,i=1) (1)
(n=4,i=2) (n=3,i=0) (n=2,i=0) (1)
                    (n=2,i=1) (1)
          (n=3,i=1) (n=2,i=0) (1)
                    (n=2,i=1) (1)
          (n=3,i=2) (n=2,i=0) (1)
                    (n=2,i=1) (1)
(n=4,i=3) (n=3,i=0) (n=2,i=0) (1)
                    (n=2,i=1) (1)
          (n=3,i=1) (n=2,i=0) (1)
                    (n=2,i=1) (1)
          (n=3,i=2) (n=2,i=0) (1)
                    (n=2,i=1) (1)
*/

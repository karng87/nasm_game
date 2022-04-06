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


   0b_00111 = [c,b,a] = 7

   0b_01011 = [d,b,a] = 11
   0b_01101 = [d,c,a] = 13
   0b_01110 = [d,c,b] = 14

   0b_10110 = [c,b] = 22

   0b_10011 = [b,a] = 19
   0b_10101 = [c,a] = 21
   0b_11001 = [d,a] = 25
   0b_11010 = [d,b] = 26
   0b_11100 = [d,c] = 28
*/
/*
   0b_00011
   0b_00101
   0b_00110

   0b_01001
   0b_01010
   0b_01100

   0b_10001
   0b_10010
   0b_10100
   0b_11000
*/

/*
   0b_000111 = [3]

   0b_001011 = [3]
   0b_001101 = [3]
   0b_001110 = [3]

   0b_010110 = [3]

   0b_010011 = [b,a] = 19
   0b_010101 = [3]
   0b_011001 = [3] = 25
   0b_011010 = [3] = 26
   0b_011100 = [3]

   0b_101010 = [-3]
   0b_101100 = [-3]
   0b_100110 = [-3]

   0b_100011 = [-3]
   0b_100101 = [-3]
   0b_101001 = [-3]
   0b_110001 = [3]
   0b_110010 = [3]
   0b_110100 = [3]
   0b_111000 = [3]
   */

/******
   el_dcba
   0b_000000 = []
   0b_000001 = [a]
   0b_000010 = [b]
   0b_000011 = 2
   0b_000100 = [c]
   0b_000101 = 2
   0b_000110 = 2
   0b_000111 = [3]
   0b_001000 = [d]
   0b_001001 = 2
   0b_001010 = 2
   0b_001011 = [3]
   0b_001100 = 2
   0b_001101 = [3]
   0b_001110 = [3]

   0b_001111 - [d,c,b,a]
   0b_010000 = []
   0b_010001 = 2
   0b_010010 = 2
   0b_010011 = [b,a] = 19

   0b_010100 = 2
   0b_010101 = [3]
   0b_010110 = [3]
   
   0b_010111 = [c,b,a] 
   0b_011000 = 2
   0b_011001 = [3] = 25
   0b_011010 = [3] = 26

   0b_011011 = [d,b,a] 
   0b_011100 = [3]

   0b_011101 = [d,c,a] 
   0b_011110 = [d,c,b] 
   0b_011111 - [d,c,b,a]
   0b_100000 = []
   0b_100001 = 2
   0b_100010 = 2
   0b_100011 = [-3]

   0b_100100 = 2
   0b_100101 = [-3]
   0b_100110 = [-3]

   0b_100111 = [c,b,a] = 7
   0b_101000 = 2
   0b_101001 = [-3]
   0b_101010 = [-3]

   0b_101011 = [d,b,a] = 11
   0b_101100 = [-3]

   0b_101101 = [a] = 13
   0b_101110 = [d,c,b] = 14
   0b_101111 - [d,c,b,a]
   0b_110000 = 2
   0b_110001 = [3]
   0b_110010 = [3]

   0b_110011 = [b,a] = 19
   0b_110100 = [3]

   0b_110101 = [c,a] = 21
   0b_110110 = [c,b] = 22
   0b_110111 = [c,b,a] 
   0b_111000 = [3]

   0b_111001 = [d,a] = 25
   0b_111010 = [d,b] = 26
   0b_111011 = [d,b,a] 
   0b_111100 = [d,c] = 28
   0b_111101 = [d,c,a] 
   0b_111110 = [d,c,b] 
   0b_111111 - [d,c,b,a]
*/
/*
   0b_01111 - [d,c,b,a]
   0b_10111 = [c,b,a] 
   0b_11011 = [d,b,a] 
   0b_11101 = [d,c,a] 
   0b_11110 = [d,c,b] 

*/

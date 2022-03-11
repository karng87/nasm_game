#include <jbits.h>

void jb_swap(int* a, int* b){*a ^= *b ^= *a ^= *b;}
int jb_odd(int x){return (x&1)?1:0;}
int jb_even(int x){return !jb_odd(x)?1:0;}
int jb_is_nth(int x, int n){return (x & (1<<n)) ? 1:0;}
int jb_set_nth(int x, int n){int y= x|(1<<n);return y;}
int jb_unset_nth(int x, int n){int y = x & ~(1<<n);return y;}
int jb_toggle_nth(int x, int n){int y = x ^ (1<<n);return y;}
int jb_turnoff_rightmost(int x){int y = x & (x-1);return y;}
int jb_isolate_rightmost_1bit(int x){int y = x &= (-(x));return y;}
int jb_propagate_rightmost2right(int x){int y = (x |(x-1));return y;}
int jb_isolate_rightmost_0bit(int x){int y = ~(x) & (x+1);return y;}
int jb_turnon_rightmost_0bit(int x){int y = x | (x+1);return y;}

// algorithm
void _jb_powerset(int n, char* src,char** dest){
  for(int i=0;i<(1<<n);i++){
    for(int j=0;j<n;j++){
      if(i&1<<j){
        *(*(dest+i)+j)= *(src+j);
      }
    }
  }
}
void jb_powerset(int n, char* src,char** dest){
  for(int i=0;i<(1<<n);i++){
    for(int j=0,k=i;k;j++,k>>=1){
      if(k&1){
        *(*(dest+i)+j)= *(src+j);
      }
    }
  }
}

#include <jbits.h>
#include <stdbool.h>
// 1010(a) ^= 1100(b) := 0110(a)
// 1100(b) ^= 0110(a) := 1010(b)
// 0110(a) ^= 1010(b) := 1100(a)
void jb_swap(int* a, int* b){*a ^= *b ^= *a ^= *b;}
bool jb_odd(int x){return (x&1)?true:false;}
bool jb_even(int x){return (x&1)?false:true;}
bool jb_is_nth(int x, int n){return (x & (1<<n)) ? true:false;}
// set => or(1<<n)
int jb_set_nth(int x, int n){int y= x|(1<<n);return y;}
// unset => and not(1<<n)
int jb_unset_nth(int x, int n){int y = x & ~(1<<n);return y;}
// toggel => xor (1<<n)
int jb_toggle_nth(int x, int n){int y = x ^ (1<<n);return y;}
// off last => and (x-1)
int jb_turnoff_rightmost(int x){int y = x & (x-1);return y;}

// 0110100  ( x)
// 1001100  (-x)
// get none zero last bit
int jb_isolate_rightmost_1bit(int x){int y = x &= (-(x));return y;}

// 0110100
// 0110011
// last none zero bit -> 전파 시킴
int jb_propagate_rightmost2right(int x){int y = (x |(x-1));return y;}

// 0110111 ( x)
// 1001000 (not x)
// 0111000 (x+1)
// get the last zero bit
int jb_isolate_rightmost_0bit(int x){int y = ~(x) & (x+1);return y;}

// 0110111 (  x)
// 0111000 (x+1)
// set the last zero bit
int jb_turnon_rightmost_0bit(int x){int y = x | (x+1);return y;}

// algorithm

void _jb_powerset(int n, char* src,char** dest){
  for(int i=0;i<(1<<n);i++){
    for(int j=0;j<i;j++){
      if(i&1<<(j+1)){
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

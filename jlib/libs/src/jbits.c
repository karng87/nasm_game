#include <jbits.h>
// 1010(a) ^= 1100(b) := 0110(a)
// 1100(b) ^= 0110(a) := 1010(b)
// 0110(a) ^= 1010(b) := 1100(a)
void jb_swap(int* a, int* b){*a ^= *b ^= *a ^= *b;}
void jb_swap_c(char * a, char * b){*a ^= *b ^= *a ^= *b;}
bool jb_odd(int x){return (x&1)?true:false;}
bool jb_even(int x){return (x&1)?false:true;}
bool jb_is_set_nth(int x, int n){return (x & (1<<n)) ? true:false;}
// set => or(1<<n)
int jb_set_nth(int x, int n){return x | (1<<n);}
// unset => and not(1<<n)
int jb_unset_nth(int x, int n){return x & ~(1<<n);}
// toggel => xor (1<<n)
int jb_toggle_nth(int x, int n){return x ^ (1<<n);}

// 0110100  ( x)
// 1001100  (-x) minus is 2's compleement
// 0000100
// get last 1 bit 0110100 -> 0000100
int jb_rightmost_1bit(int x){return x & (-(x));}

// 0110100
// 0110011
// 0110111
// last none zero bit -> 전파 시킴 01010000=>01011111
int jb_propagate_rightmost(int x){return (x | (x-1));}
int jb_turnoff_rightmost(int x){return x & (x-1);}

// 0110111 ( x)
// 1001000 (not x)
// 0111000 (x+1)
// 0001000
// get the last zero bit 10101011 => 00000100
int jb_only_lastmost_zero_bit(int x){return ~(x) & (x+1);}

// 0100111 (  x)
// 0101000 (x+1)
// 0101111
// set the last zero bit 10100011 => 10100111
int jb_turnon_rightmost_0bit(int x){return x | (x+1);}

// algorithm

void jb_powerset(int n, char* src,char** dest){
  for(int i=0;i<(1<<n);i++){
    for(int j=0;j<i;j++){
      if(i & 1<<(j+1)){
        *(*(dest+i)+j)= *(src+j);
      }
    }
  }
}
void _jb_powerset(int n, char* src,char** dest){
  for(int i=0;i<(1<<n);i++){
    for(int j=0,k=i;k;j++,k>>=1){
      if(k&1){
        *(*(dest+i)+j)= *(src+j);
      }
    }
  }
}

struct jData* jpset(int n){
  struct jData* idx;
  idx = malloc(sizeof(struct jData));
  idx->sizes = 1<<n;
  idx->used = 1<<n;
  idx->stride = 1;
  idx->p = (unsigned int *)malloc((idx->sizes) * (idx->stride));
  int m = 1<<n;
  for(int i=0; i < 1<<n; i++){

  }
}

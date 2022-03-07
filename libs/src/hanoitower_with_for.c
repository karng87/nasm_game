#include <stdio.h>
#include <jprint.h>

void hanoi_for(int n);
int main(){
  hanoi_for(3);
  return 0;
}

void hanoi_for(int n){
  for(int i=1; i<(1<<n)/*- i< 2^n -*/; i++){
    printf("(i:%d)&(i-1:%d)=>%d)\n",i,i-1,i|(i-1));
    printf("(i&(i-1)) mod 3 ::: %d -> %d ::: ((i|(i-1))+1) mod 3\n",(i&(i-1))%3,(((i|(i-1))+1)%3));
  }
}
/*
   i & (i-1):: toggle all the bits from the rightmost set bit of i
    i         = 0b_1010_1_000
    i-1       = 0b_1010_0_111
   ---------------------------
    i&(i-1)   = 0b_1010_0_000
*/
/*
   i | (i-1):: set 0 all the bits from the rightmost set bit to end of i
    i         = 0b_1010_1_000
    i-1       = 0b_1010_0_111
   ---------------------------
    i&(i-1)   = 0b_1010_0_000
*/

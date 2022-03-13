#include<jbits.h>
#include<jalgorithm.h>
#include<stdio.h>

static int dest_idx;
void _ja_permutation(int,char*,int,char**);

void ja_permutation(int swap_idx,char* src,int size,char** dest){
  dest_idx=0;
  printf ("before: dest_idx=%d\n",dest_idx);
  _ja_permutation(swap_idx,src,size,dest);
}
void _ja_permutation(int swap_idx, char* src,int size, char** dest){
  if(swap_idx==size){
    for(int i=0;i<size;i++){
      *(*(dest+dest_idx)+i) = *(src+i);
    }
    dest_idx++;
    return;
  }
  for(int i=swap_idx;i<size;i++){
    if(swap_idx!=i) jb_swap_c(src+swap_idx,src+i);
    _ja_permutation(swap_idx+1,src,size,dest);
    if(swap_idx!=i) jb_swap_c(src+swap_idx,src+i);
  }
}

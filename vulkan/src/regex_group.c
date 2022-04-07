#include <stdio.h>
#include <regex.h>
#include <core/logger.h>

int main(){
  KINFO("regex group");
  regex_t rg_cmp;
  char src[] = {"\\epsilon_{i,j,k}\\sum_{i,j,k=1}^{3}sin(3x)x^n"};
  const char pattern[] ={".*(sin)\\(([0-9]*)([a-z]+)\\)([a-z]+)(\\^*)([a-z0-9]*)"};
  if(regcomp(&rg_cmp,pattern,REG_EXTENDED)){
     KFATAL("regcomp failed \n\t%s: %s",src,pattern); 
     return -1;
  }
  KINFO("rg_t:%d",rg_cmp.re_nsub); 
  
  regmatch_t rg_idx[rg_cmp.re_nsub+1];

  if(!regexec(&rg_cmp,src,rg_cmp.re_nsub+1,rg_idx,0)){
    for(int i=0;i<rg_cmp.re_nsub+1;i++){
      if(rg_idx[i].rm_so == -1){KWARN("no capture\n");break;}
      int start= rg_idx[i].rm_so;
      int end = rg_idx[i].rm_eo;
      printf("Match Group[%d][%u-%u]: ",i,start,end);
      for(int j = start; j < end; j++){printf("%c",*(src+j));}
      printf("\n");
    }
  }
  return 0;
}

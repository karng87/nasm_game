#include <stdio.h>
#include <regex.h>
#include <log/log.h>

int main(){
  INFO("regex group");
  regex_t rg_t;
  char src[] = {"\\epsilon_{i,j,k}\\sum_{i,j,k=1}^{3}sin(3x)x^n"};
  const char pattern[] ={".*(sin)\\(([0-9]*)([a-z]+)\\)([a-z]+)([^]*)([a-z0-9]*)"};
  size_t max_capture = 6;
  regmatch_t rm_idx[max_capture];
  if(regcomp(&rg_t,pattern,REG_EXTENDED)){
     FATAL("regcomp failed \n\t%s: %s",src,pattern); 
     return -1;
  }
  if(!regexec(&rg_t,src,max_capture,rm_idx,0)){
    for(int i=0;i<max_capture;i++){
      if(rm_idx[i].rm_so == -1){WARN("no capture\n");break;}
      INFO("Match Group No: %d [%u-%u]: %s",i,rm_idx[i].rm_so,rm_idx[i].rm_eo,src+rm_idx[i].rm_so);
    }
  }
  return 0;
}

#include<string.h>

char *reverse(char *str){
  int len = strlen(str);
  char tmp;
  for(int i=0; i<len/2; i++){
    tmp = *(str+i);
    *(str+i) = *(str+len-1-i);
    *(str+len-1-i) = tmp;
  }
  return str;
}

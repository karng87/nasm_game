#include<stdio.h>
#include<stdlib.h>
#include<wchar.h>
#include<locale.h>

int main(){
  const wchar_t * cmd = L"/home/jkarng/.config/nvim/bin/tts 한글test";
  setlocale(LC_ALL,NULL);
  //system(cmd);
  printf("tts 한글\n");
  return 0;
}

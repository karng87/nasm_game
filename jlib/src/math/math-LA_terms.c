#include<stdio.h>
#include<stdlib.h>

void terms(){
  system("tts \"nonzero row\"");
  system("tts \"nonzero column\"");
  system("tts \"leading entry of row\"");
  system("tts \"echelon form\"");
  system("tts \"reduced echelon form\"");
  system("tts \"uniqueness of the reduced echelon form\"");
  system("tts \"row reduction algorithm\"");
  system("tts \"forward and backward phase\"");
  system("tts \"pivot column, pivot position\"");
  system("tts \"1) start with most left nonzero column, this is pivot column\"");
  system("tts \"1-1) pivot position\"");
  system("tts \"1-2) pivot column\"");
}
int main(){
  terms();
  return 0;
}

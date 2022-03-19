#include<stdio.h>
#include<stdlib.h>

void matrix_terms(){
  system("tts \"Matrix\"");
  system("tts \"Identity matrix\"");
  system("tts \"Elementary matrix\"");
  system("tts \"Diagonal matrix\"");
  system("tts \"trianglar matrix\"");
  system("tts \"Upper trianglar matrix\"");
  system("tts \"Lower trianglar matrix\"");
  system("tts \"Transverse matrix\"");
  system("tts \"augmented matrix\"");
  system("tts \"coefficient matrix\"");
}

void terms_tts(){
  matrix_terms();
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
  terms_tts();
  return 0;
}

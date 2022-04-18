#include <stdio.h>
#include <stdlib.h>
#include <shader_compile.h>

GLuint compileShader(const char* vertex_file,const char* fragment_file){
  GLuint vertexShaderID = glCreateShader(GL_VERTEX_SHADER);
  GLuint fragmentShaderID = glCreateShader(GL_FRAGMENT_SHADER);
  char* vsCode;
  unsigned int len;
  FILE* fd = fopen(vertex_file,"r");
  if(fd){
    fseek(fd,0,SEEK_END); // fseek(fd,distance,stating point) jump 0 from SEEK_END=end point of fd
    len = ftell(fd);  // ftell(fd): return current index position
    fseek(fd,0,SEEK_SET); // fseek(fd,distance(0),basis(SEEK_SET)) jump 0 from SEEK_SET=stagint point of fd
    vsCode = malloc(len+1);
    if(vsCode){
      fread(vsCode,sizeof(char),len,fd);
    }
  }



  return 0;
} 

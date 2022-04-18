#include <stdio.h>
#include <stdlib.h>

#include <GL/glew.h>
#include <GLFW/glfw3.h>
void print_ver();
int main(){
  if(!glfwInit()){
    fprintf(stderr,"Failed to initialize GLFW\n");
    return -1;
  }

  glfwWindowHint(GLFW_SAMPLES,4);
  glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR,3);
  glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR,3);
  glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
  GLFWwindow* win =glfwCreateWindow(800,640,"Tutorial",NULL,NULL);
  if(win==NULL){
    fprintf(stderr, "Failed to open GLFW window");
    glfwTerminate();
    return -1;
  }
  glfwMakeContextCurrent(win);
  glewExperimental = GL_TRUE;
  if(glewInit() !=GLEW_OK){
    fprintf(stderr, "Failed to initialize GLEW\n");
    return -1;
  }

  glfwSetInputMode(win,GLFW_STICKY_KEYS, GL_TRUE);
  glfwSwapInterval(1);
  double lastTime = glfwGetTime();
  int numFrames=0;
  static const float vdata[]={
    -1.,-1.,0.,
    1.,-1.,0.,
    0.,1.,0.,
  };

  GLuint vbuf;
  glGenBuffers(1,&vbuf);
  glBindBuffer(GL_ARRAY_BUFFER,vbuf);
  glBufferData(GL_ARRAY_BUFFER,sizeof(vdata),vdata,GL_STATIC_DRAW);

  while(glfwGetKey(win,GLFW_KEY_ESCAPE)!= GLFW_PRESS && glfwWindowShouldClose(win)==0){
    glEnableVertexAttribArray(0);
    glBindBuffer(GL_ARRAY_BUFFER,vbuf);
    glVertexAttribPointer(0,3,GL_FLOAT,GL_FALSE,0,(void*)0);
    glDrawArrays(GL_TRIANGLES,0,3);
    glDisableVertexAttribArray(0);
    glClearColor(0,0,1,0);
    double currentTime = glfwGetTime();
    numFrames++;
    if(currentTime - lastTime >=1.){
      printf("%f s/frame %d fps \n",1./numFrames,numFrames);
      numFrames = 0;
      lastTime = currentTime;
      //glClearColor(1,0,0,0);
    }

    glClear(GL_COLOR_BUFFER_BIT);
    glfwSwapBuffers(win);
    glfwPollEvents();
  }

  glfwDestroyWindow(win);
  glfwTerminate();
  return 0;
}

void print_ver(){
  printf("GL ver  : %s\n",glGetString(GL_VERSION));
  printf("GLSL ver: %s\n",glGetString(GL_SHADING_LANGUAGE_VERSION));
  printf("Vendor  : %s\n",glGetString(GL_VENDOR));
  printf("Renderer: %s\n",glGetString(GL_RENDERER));
}

// https://dickens.co.in/opengl-mathgl
#include<stdio.h>
#include<stdlib.h>
#include<GL/glew.h>
#include<GLFW/glfw3.h>
#include<mgl2/mgl_cf.h>

void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
    glViewport(0, 0, width, height);
}

struct Vec2{
    double x;
    double y;
};

struct Mouse{
  struct Vec2 position;
  struct Vec2 scroll;
}mouse;

void cursorPositionCallback(GLFWwindow * win, double mx, double my){
  mouse.position.x = mx;
  mouse.position.y = my;
}
void scrollCallback(GLFWwindow* win, double mx, double my){
  mouse.scroll.x = mx;
  mouse.scroll.y = my;
}
int main(){
  GLFWwindow * win;
  glfwInit();
  glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
  glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);
  win = glfwCreateWindow(800, 600, "GLFW", NULL, NULL);
    if (win == NULL) {
            fprintf(stdout,"Failed to create GLFW window");
            glfwTerminate();
            return -1;
    }
  glfwMakeContextCurrent(win);

  glewExperimental = GL_TRUE;
  if(glewInit()!=GLEW_OK){
    printf("Error:GLEW initializing failed");
    glfwTerminate();
    return -1;
  }
  
  glClearColor(1.0,1.0,1.0,1.0);
  glDisable(GL_DEPTH_TEST);
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glEnable(GL_TEXTURE_2D);

  glViewport(0, 0, 800, 600);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glOrtho(0.,800.,600.,0.,-1.,1.);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  HMDT rnd=mgl_create_data_size(100,1,0);
  HMDT in1=mgl_create_data_size(100,1,0);
  HMGL gl = mgl_create_graph(800,600);
  //HMGL gl = mgl_create_graph_gl(800,600);
  mgl_data_modify(rnd,"0.4*rnd+0.1+sin(6*pi*x)",0);
  mgl_data_modify(in1,"0.3+sin(6*pi*x)",0);
  //mgl_set_range_val(gl,'y',-1.5,1.5);
  mgl_plot(gl,rnd,". ","");
  mgl_plot(gl,rnd,"b","");
  mgl_box(gl);
  int w = mgl_get_width(gl);
  int h = mgl_get_height(gl);
  int channels = 4;
  char* surface_data = malloc(channels*w*h*sizeof(char));
  const unsigned char * bitmap = mgl_get_rgba(gl);
  memcpy(surface_data, bitmap,(unsigned long)(channels*w*h));
  printf("awidth: %d",w);
  printf("aheight: %d",h);
  unsigned int * tid = malloc(sizeof(int));
  glGenTextures(1,tid);
  glEnable(GL_TEXTURE_2D);

  glBindTexture(GL_TEXTURE_2D, *tid);

  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_BASE_LEVEL,0);
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAX_LEVEL,0);
  glTexImage2D(
      GL_TEXTURE_2D,
      0,
      GL_RGBA,
      w,
      h,
      0,
      GL_BGRA,
      GL_UNSIGNED_BYTE,
      surface_data
      );
  glfwSetInputMode(win,GLFW_STICKY_KEYS,GL_TRUE);

  //glfwSetFramebufferSizeCallback(win, framebuffer_size_callback);
  //glfwSetCursorPosCallback(win,cursorPositionCallback);
  //glfwSetScrollCallback(win, scrollCallback);

  while(glfwGetKey(win,GLFW_KEY_ESCAPE) != GLFW_PRESS && !glfwWindowShouldClose(win)){
    glBegin(GL_QUADS);
      glTexCoord2f(0.0f,0.0f);
      glVertex2f(0.0f,0.0f);
      glTexCoord2f(1.0f,0.0f);
      glVertex2f((float)w,0.0f);
      glTexCoord2f(1.0f,1.0f);
      glVertex2f((float)w,(float)h);
      glTexCoord2f(0.0f,1.0f);
      glVertex2f(0.0f,(float)h);
    glEnd();

    glfwSwapBuffers(win);
    glfwPollEvents();
  }
  glfwTerminate();
  return 0;
}

#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

double seedrand(){
  time_t t;
  srand(time(&t));
  printf("Time: %zu",t);
  return (double) rand() / RAND_MAX;
}
struct Ball{
  double x;
  double y;
  double dx;
  double dy;
};
int W=640;
int H=480;
float ratio;

void keyCallback(GLFWwindow * window, int key, int scancode, int action, int mods){
  if(key == GLFW_KEY_ESCAPE && action == GLFW_PRESS) glfwWindowShouldClose(window);
}

void framebufferSizeCallback(GLFWwindow * win, int w, int h){glViewport(0,0,w,h);}

int main(){
  GLFWwindow * win;
  glfwInit();
  win = glfwCreateWindow(640, 480, "glfw pong game", 0, 0);
  // OpenGL context
  glfwMakeContextCurrent(win);
  if(!gladLoadGLLoader((GLADloadproc) glfwGetProcAddress)){
    printf("Failed to initialize GLAD");
    return -1;
  }
  const unsigned char* glversion = glGetString(GL_VERSION);
  printf ("GL_VERSION: %s\n",glversion);

  // Making the OpenGL context current
  glfwSetKeyCallback(win, keyCallback);
  glfwSetFramebufferSizeCallback(win,framebufferSizeCallback);

  struct Ball ball = {
    .x=seedrand(),
    .y=seedrand(),
    .dx = 1.0,
    .dy = 1.0};

  while(!glfwWindowShouldClose(win)){
    glfwGetFramebufferSize(win, &W, &H);
    glViewport(0, 0, W, H);

    glClear(GL_COLOR_BUFFER_BIT);
    glfwSwapBuffers(win);
    // poll 결정할것인가 기권할것인가?
    glfwPollEvents();
  }
  glfwDestroyWindow(win);
  glfwTerminate();
  return 0;
}

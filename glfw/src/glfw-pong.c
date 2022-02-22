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
  double x ;
  double y ;
  double dx;
  double dy;
};
int W=640;
int H=480;
float ratio;

void keyboardCallback(GLFWwindow * window, int key, int scancode, int action, int mods){
  if(key == GLFW_KEY_ESCAPE && action == GLFW_PRESS)
    glfwWindowShouldClose(window);
}
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

  // Making the OpenGL context current
  glfwSetKeyCallback(win, keyboardCallback);

  struct Ball ball = {
    .x=seedrand(),
    .y=seedrand(),
    .dx = 1.0,
    .dy = 1.0};

  while(!glfwWindowShouldClose(win)){
    glfwGetFramebufferSize(win, &W, &H);
    glViewport(0, 0, W, H);

    glClear(GL_COLOR_BUFFER_BIT);
    /*
    glMatrixMode(GL_PRO);
    glLoadIdentity();

    glOrtho(-ratio, ratio, -1.f, 1.f, 1.f,-1.f);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();

    // draw ball
    glPushMatrix();
    glTranslated(ball.x, ball.y, 0);
    glScalef(0.05f, 0.05f, 1);

    glBegin(GL_QUADS);
    glColor3f(0.5f, 0.0f, 0.0f);
    glVertex3f(-0.5f, -0.5f, 0.0f);
    glVertex3f(-0.5f, 0.5f, 0.0f);
    glVertex3f(0.5f, 0.5f, 0.0f);
    glVertex3f(0.5f, -0.5f, 0.0f);
    glEnd();

    glPopMatrix();
    //== end draw ball ==//
    */

    glfwSwapBuffers(win);
    // poll 결정할것인가 기권할것인가?
    glfwPollEvents();
  }
  glfwDestroyWindow(win);
  return 0;
}

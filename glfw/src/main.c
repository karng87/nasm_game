#include <stdio.h>
#include <glad/glad.h>
#include <GLFW/glfw3.h>

void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
    glViewport(0, 0, width, height);
}

struct Mouse{
  struct Vec2{
    double x;
    double y;
  };
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
  //glfwWindowHint(GLFW_RESIZABLE, GLFW_TRUE);
  win = glfwCreateWindow(800, 600, "GLFW", NULL, NULL);
    if (win == NULL) {
            fprintf(stdout,"Failed to create GLFW window");
            glfwTerminate();
            return -1;
    }
  glfwMakeContextCurrent(win);
  if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
    fprintf (stdout, "Failed to initialize GLAD");
    return -1;
  }
  glViewport(0, 0, 800, 600);
  glfwSetFramebufferSizeCallback(win, framebuffer_size_callback);
  glfwSetCursorPosCallback(win,cursorPositionCallback);
  glfwSetScrollCallback(win, scrollCallback);

  while(!glfwWindowShouldClose(win)){
    glfwSwapBuffers(win);
    glfwPollEvents();
    fprintf(stdout,"Mouse x: %f", mouse.scroll.x);
    fprintf(stdout,"Mouse y: %f", mouse.scroll.y);
  }
  glfwDestroyWindow(win);
  glfwTerminate();
  return 0;
}

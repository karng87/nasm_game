#include <iostream>
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
int main() {
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    //glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
    GLFWwindow* window = glfwCreateWindow(800, 600, "LearnOpenGL", NULL, NULL);
    if (window == NULL) {
            std::cout << "Failed to create GLFW window" << std::endl;
            glfwTerminate();
            return -1;
    }
    glfwMakeContextCurrent(window);
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        std::cout << "Failed to initialize GLAD" << std::endl;
        return -1;
    }
    glViewport(0, 0, 800, 600);
    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);
  glfwSetCursorPosCallback(window,cursorPositionCallback);
  glfwSetScrollCallback(window, scrollCallback);
    while(!glfwWindowShouldClose(window)) {
        glfwSwapBuffers(window);
        glfwPollEvents();    
    }
    glfwTerminate();
    return 0;
}

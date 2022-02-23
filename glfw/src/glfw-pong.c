#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

static const char* vertex_shader_text =
"#version 110\n"
"uniform mat4 MVP;\n"
"attribute vec3 vCol;\n"
"attribute vec2 vPos;\n"
"varying vec3 color;\n"
"void main()\n"
"{\n"
"    gl_Position = MVP * vec4(vPos, 0.0, 1.0);\n"
"    color = vCol;\n"
"}\n";
 
static const char* fragment_shader_text =
"#version 110\n"
"varying vec3 color;\n"
"void main()\n"
"{\n"
"    gl_FragColor = vec4(color, 1.0);\n"
"}\n";

double seedrand(){
  time_t t;
  srand(time(&t));
  printf("Time: %zu",t);
  return (double) rand() / RAND_MAX;
}
int W=640;
int H=480;
struct Vertex{float x,y; float r,g,b;};
void keyCallback(GLFWwindow * window, int key, int scancode, int action, int mods);
void framebufferSizeCallback(GLFWwindow * win, int w, int h){glViewport(0,0,w,h);}
char ** loadfile(char * filename);

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
  glfwSwapInterval(1);

  // Making the OpenGL context current
  glfwSetKeyCallback(win, keyCallback);
  glfwSetFramebufferSizeCallback(win,framebufferSizeCallback);
  GLuint vertex_buffer, vertex_shader, fragment_shader, program;
  GLint mvp_location, vpos_location, vcol_location;
  glGenBuffers(1,&vertex_buffer);
  glBindBuffer(GL_ARRAY_BUFFER, vertex_buffer);
  struct Vertex vertices[3]={{-0.6f,-0.4f,1.f,0.f,0.f},{0.6f,-0.4f,0.f,1.f,0.f},{0.f,0.6f,0.f,0.f,1.f}};
  glBufferData(GL_ARRAY_BUFFER,sizeof(vertices), vertices, GL_STATIC_DRAW);

  vertex_shader = glCreateShader(GL_VERTEX_SHADER);
  glShaderSource(vertex_shader, 1, &vertex_shader_text,NULL);
  glCompileShader(vertex_shader);

  fragment_shader = glCreateShader(GL_FRAGMENT_SHADER);
  glShaderSource(fragment_shader,1,&fragment_shader_text,NULL);
  glCompileShader(fragment_shader); 

  program = glCreateProgram();
  glad_glAttachShader(program,vertex_shader);
  glad_glAttachShader(program,fragment_shader);
  glLinkProgram(program);

  mvp_location = glad_glGetUniformLocation(program,"MVP");
  vpos_location = glGetAttribLocation(program, "vPos");
  vcol_location = glGetAttribLocation(program, "vCol");
 
  glEnableVertexAttribArray(vpos_location);
  glVertexAttribPointer(vpos_location, 2, GL_FLOAT, GL_FALSE, sizeof(vertices[0]), (void*) 0);
  glEnableVertexAttribArray(vcol_location);
  glVertexAttribPointer(vcol_location, 3, GL_FLOAT, GL_FALSE, sizeof(vertices[0]), (void*) (sizeof(float) * 2));

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
void keyCallback(GLFWwindow * window, int key, int scancode, int action, int mods){
  if(key == GLFW_KEY_ESCAPE && action == GLFW_PRESS) glfwWindowShouldClose(window);}

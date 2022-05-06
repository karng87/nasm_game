#include <stdio.h>
#include <stdlib.h>

#include <GL/glew.h>
#include <GLFW/glfw3.h>
void print_ver();
int main(){
  glfwInit();
	GLFWwindow* w = glfwCreateWindow(600, 600, "vimsucks", NULL, NULL);
	glfwMakeContextCurrent(w);
  glewInit();
	float t[] =
	{
		-1.f, -1.f, 0.f,
		0.f, 1.f, 0.f,
		1.f, -1.f, 0.f
	};
	uint32_t v;
	glGenBuffers(1, &v);
	glBindBuffer(GL_ARRAY_BUFFER, v);
	glBufferData(GL_ARRAY_BUFFER, sizeof(t), &t[0], GL_STATIC_DRAW);
  printf("sizeof(t):%lu\n",sizeof(t)); //36
  printf("sizeof(t[0]):%lu\n",sizeof(t[0])); //4
  printf("t*t/t[0]: %lu\n",sizeof(t)*sizeof(t)/sizeof(t[0]));
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(float)*3,
		 (void*)0);
	glEnableVertexAttribArray(0);
	glViewport(0, 0, 600, 600);
	while(!glfwWindowShouldClose(w))
	{
		glClear(GL_COLOR_BUFFER_BIT);
		glDrawArrays(GL_TRIANGLES, 0, 3);
		glfwSwapBuffers(w);
		glfwPollEvents();
	}
	glfwTerminate();

}

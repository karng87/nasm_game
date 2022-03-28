#include<mgl2/mgl.h>

int main(){
  mglGraph gr;
  gr.FPlot("sin(x)");
  gr.WriteFrame("test.cpp.png");
}

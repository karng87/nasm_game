#include<mgl2/qt.h>
int fBox(mglGraph *gr){
  gr->SubPlot(3,3,0);
  gr->Title("rz=-1");
  gr->Rotate(50,60);
  gr->Puts(mglPoint(0,0,-1),"(0,0,-1)");
  //gr->Shear(0.3,0);
  gr->Box("r");

  gr->SubPlot(3,3,1);
  gr->Title("zr=-1");
  gr->Shear(0.0,0.3);
  gr->Puts(mglPoint(0,0,-1),"(0,0,-1)");
  gr->Rotate(50,60);
  gr->Box("b");

  gr->SubPlot(3,3,2);
  gr->Title("(0,0,-1)");
  gr->Puts(mglPoint(0,0,-1),"(0,0,-1)");
  gr->Rotate(50,60);
  gr->Box();

  gr->SubPlot(3,3,3);
  gr->Title("(0,0,-1)");
  gr->Rotate(50,60);
  gr->Puts(mglPoint(0,0,-1),"(0,0,-1)");
  gr->Box();

  gr->SubPlot(3,3,4);
  gr->Title("(1,0,0)");
  gr->Puts(mglPoint(1,0,0),"(1,0,0)");
  gr->Box();

  gr->SubPlot(3,3,5);
  gr->Title("(0,1,0)");
  gr->Puts(mglPoint(0,1,0),"(0,1,0)");
  gr->Box();

  gr->SubPlot(3,3,6);
  gr->Title("(0,0,1)");
  gr->Puts(mglPoint(0,0,1),"(0,0,1)");
  gr->Box();
  return 0;
}
int main(){
  mglQT gr(fBox, "Box");
  return gr.Run();
}

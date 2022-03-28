#include<mgl2/qt.h>
namespace qt{
  int axis(mglGraph *gr){
    gr->SubPlot(2,2,0);
    gr->Title("Axis origin Grid");
    gr->SetOrigin(0,0);
    gr->Axis();
    gr->Grid();
    gr->FPlot("x^3");
    return 0;
  }
}// end namespace qt 
int main(){
  mglQT gr(qt::axis,"axix");
  return gr.Run();
}

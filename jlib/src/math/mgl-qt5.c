//#include<mgl2/mgl_cf.h>
#include<mgl2/qt.h>
int sample(HMGL gr, void*){
  mgl_rotate(gr,60,40,0);
  mgl_box(gr);
  return 0;
}
int main(){
  HMGL gr = mgl_create_graph_qt(sample,"MathGL example",0,0);
  return mgl_qt_run();
}


#include<mgl2/mgl_cf.h>
#include<mgl2/fltk.h>

int sample(HMGL gr, void*){
  mgl_rotate(gr,50,60,0);
  mgl_box(gr);
  return 0;
}
int main(){
  HMGL gr;
  gr=mgl_create_graph_fltk(sample,"FLTK HMGL",0,0);
  //mgl_fltk_thr();
  mgl_fltk_run();
  mgl_delete_graph(gr);
  return 0;
}

#include<mgl2/mgl_cf.h>
#include<mgl2/glut.h>
#include <mgl2/surf.h>

int sample(HMGL gr, void*){
  mgl_subplot(gr,1,1,0,"");
  mgl_title(gr,"\\sum_{i}^{n}Axis","",12);
  mgl_set_origin(gr,0,0,0);
  mgl_axis(gr,"xyz",0,0);
  //mgl_grid(gr, 0, "", "");
  mgl_fplot(gr, "x^3", "", "");
  return 0;
}
int main(){
  HMGL gr;
  gr=mgl_create_graph_glut(sample,"Axis",0,0);
  mgl_glut_update(gr);
  mgl_delete_graph(gr);
  return 0;
}

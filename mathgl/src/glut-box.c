#include<mgl2/mgl_cf.h>
#include<mgl2/glut.h>

int sample(HMGL gr, void *){
  mgl_rotate(gr,60,40,0);
  mgl_box(gr);
  return 0;
}

int main(){
  HMGL gr;
  gr=mgl_create_graph_glut(sample,"Mathgl in c",0,0);
  mgl_glut_update(gr);
  mgl_delete_graph(gr);
  return 0;
}

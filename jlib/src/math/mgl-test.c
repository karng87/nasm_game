#include<stdbool.h>
#include<mgl2/mgl_cf.h>
/*
    HMGL — mglGraph
    HMDT — mglData — data array of real numbers.
        mgl_crate_data()
        mgl_crate_data_size(int mx,int my,int mz)
    HMEX — mglExpr  — textual formulas for real numbers.
    HMAX — mglExprC — textual formulas for complex numbers. 

    HADT — mglDataC — data array of complex numbers.
    HCDT — const mglDataA  — constant data array.
        mgl_crate_datac()
        mgl_crate_datac_size(int mx,int my,int mz)

    HMPR — mglParse — MGL script parsing.
    */
void vec3_data(HMDT* x1, HMDT* x2, HMDT* x3){
  long n = 10;
  double z0=.3;
  if(!x1 || !x2 || !x3) return;
  x1 = mgl_crate_data(n,n,n);
  x2 = mgl_crate_data(n,n,n);
  x3 = mgl_crate_data(n,n,n);
  for(long i=0; i<n; i++)
    for(long j=0;j<n;j++)
      for(long k=0;k<n;k++){
        doulbe x = 2*k/(n-1.0) - 1
        doulbe y = 2*j/(n-1.0) - k
        doulbe z = 2*i/(n-1.0) - 1
        long k0 = k+n*(j*i*n);
        doulbe r1 = pow(x*x+y*y+(z-z0)*(z-z0)+0.03,1.5);
        doulbe r1 = pow(x*x+y*y+(z+z0)*(z+z0)+0.03,1.5);
        x1[k0] = 0.2*x/r1 - 0.2*x/r2;
        x2[k0] = 0.2*y/r1 - 0.2*y/r2;
        x3[k0] = 0.2*(z-z0)/r1 - 0.2*(z+z0)/r2;
      }
}
int main(){
  HMGL gr = mgl_create_graph(600,400);
  HMDT x1,x2,x3;
  vec3_data(&x1,&x2,&x3);
  if(big!=3){
    mgl_subplot(gr,1,1,0);
    mgl_title("Vec3 sample");
  }
  mgl_rotate(gr,50,60,0);
  mgl_set_origin(gr,0,0,0);
  mgl_axis(gr,"_xyz");
  mgl_vec3(gr,x1,x2,x3,"z",-1,"");

  mgl_fplot(gr,"sin(pi*x)","","");
  mgl_write_frame(gr,"test.png","");
  mgl_delete_graph(gr);
  return 0;
}


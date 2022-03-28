#include<mgl2/mgl.h>
#include <mgl2/qt.h>

void mgls_prepare3v(mglData *ex, mglData *ey, mglData *ez){
  long n=10;
  double z0=0.3;
  if(!ex || !ey || !ex) return;
  ex->Create(n,n,n);
  ey->Create(n,n,n);
  ez->Create(n,n,n);
  for(long i=0;i<n;i++)
    for(long j=0;j<n;j++)
      for(long k=0;k<n;k++){
        double x=2*k/(n-1.)-1;
        double y=2*j/(n-1.)-1;
        double z=2*i/(n-1.)-1;
        double r1=pow(x*x+y*y+(z-z0)*(z-z0)+z0, 1.5);
        double r2=pow(x*x+y*y+(z+z0)*(z+z0)+z0, 1.5);
        long k0 = k+n*(j+i*n);
        ex->a[k0]=0.2*x/r1-0.2*x/r2;
        ey->a[k0]=0.2*y/r1-0.2*y/r2;
        ez->a[k0]=0.2*(z-z0)/r1-0.2*(z+z0)/r2;
      }

}

int mgls_vect3(mglGraph *gr){
  mglData ex,ey,ez;
  mgls_prepare3v(&ex,&ey,&ez);
  gr->SubPlot(1,1,0);
  gr->Title("$\\vec{a}$");
  gr->Rotate(50,60);
  gr->SetOrigin(0,0,0);
  gr->Axis("_xyz");
  gr->Box();
  gr->Grid3(ex,"Wx");
  gr->Grid3(ex,"W");
  gr->Grid3(ez,"Wz");
  return 0;
}

int main(int arc, char** argv){
  mglQT gr(mgls_vect3,"vector");
  return gr.Run();
}

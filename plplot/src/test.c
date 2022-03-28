/*
   sudo pacman feh
   paru plplot
*/
#include <math.h>
#include <string.h>
#include <ctype.h>

#include <plplot/plConfig.h>
#include <plplot/plplot.h>
#define NSIZE 101

int main(int argc, char **argv){
  double x[NSIZE];
  double y[NSIZE];
  double xmin =0.,xmax=1.,ymin=0.,ymax=100.;
  for(int i=0;i<NSIZE;i++){
    x[i] = (double)i/(double)(NSIZE-1);
    y[i] = ymax*x[i]*x[i]; 
  }
  plparseopts(&argc,argv,PL_PARSE_FULL);
  plinit();
  plenv(xmin,xmax,ymin,ymax,0,0);
  pllab("x","y=100 x#u2#d", "Simple PLplot demo of a 2D line plot");

  plline(NSIZE,x,y);
  plend();
  exit(0);
}

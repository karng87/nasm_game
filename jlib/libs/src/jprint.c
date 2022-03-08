#include<stdio.h>
#include <jprint.h>

void jprint_i2b(int x){
  for(int i=sizeof(x)<<3;i;i--){
    //putchar('0'+(x>>(i-1)));
    putchar('0'+((x>>(i-1))&1));
  }
}

#include<stdio.h>
#include<stdlib.h>
/**** floating pointer ****
32bit := 4byte(single precision)
  1) [31] bit(0 or 1) := sign bit (most right bit)
  2) [30~23] bit total 8bit(2^8 = 256)
      256/2 = 128
        -127(0b_0000_0000) ~ 0(0b_0111_1111) ~ 128(0b_1111_1111)
        ** bias := 부호 비트를 따로 두지 않고 반으로 나눠서 정하는 방법

  <31> [30 29 28 27 26 25 24 23] [22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0]
*/
int main(){
  printf("nomalized number := 1 <= nomalized num < basis num \n");
  printf("double point   := 64 bit 8byte \n");
  printf("sign bit [s]   := 63 bit(most left bit)\n");
  printf("mantissa [m]   := 가수부 [0~52] bit\n");
  printf("exponential [e]:= 지수부(11bit) [53~62] bit\n");
  printf("bias(1023)     := 지수부에서만 부호 비트를 따로 두지 않고 반으로 나눠서 정하는 방법\n");
  printf("s[0] & e[0] & m[0]  := +0\n");
  printf("s[1] & e[0] & m[0]  := -0\n");
  printf("s[0] & e[255] & m[0] := +oo\n");
  printf("s[1] & e[255] & m[0] := -oo\n");
  printf("s[] & e[255] & m[!=0] := NaN(not a number\n");
  printf("============\n\n");
  printf("floating point   := 32 bit 4byte \n");
  printf("sign bit [s]     := 31 bit(most left bit)\n");
  printf("mantissa [m]     := 가수부 [0~22] bit\n");
  printf("exponential [e]  := 지수부(8bit) [23~30] bit\n");
  printf("bias(127)        := 지수부에서만 부호 비트를 따로 두지 않고 반으로 나눠서 정하는 방법\n");
  printf("s[0] & e[0] & m[0]  := +0\n");
  printf("s[1] & e[0] & m[0]  := -0\n");
  printf("s[0] & e[255] & m[0] := +oo\n");
  printf("s[1] & e[255] & m[0] := -oo\n");
  printf("s[] & e[255] & m[!=0] := NaN(not a number\n");
  return 0;
}

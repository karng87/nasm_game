// nasm -felf64 x64_io.asm
// g++ -shared libmyasmprint.so x64_io.o
// g++ main.cpp -L. -lmyasmprint -Wl,-rpath=.
// ./a.out
//
// g++ -shared libmyasmprint.so x64_io.o
// g++ main.cpp -L. -lmyasmprint
// LD_LIBRARY_PATH=. ./a.out

// echo /usr/local/lib | sudo tee /etc/ld.so.conf.d/local
// sudo ldconfig
// g++ -shared libmyasmprint.so x64_io.o
// ./a.out

#include <stdio.h>
extern "C" void p_hexadecimal(__int64_t x);
extern "C" void p_decimal(__int64_t x);

extern "C" void p_newline(void);

typedef struct{
  __int8_t a8;
  __int16_t a16;
  __int32_t a32;
  __int64_t a64;
  __int8_t b8;
  __int16_t b16;
  __int32_t b32;
  __int64_t b64;
}mType;

int main(){
  mType x;
  x.a8 = 0x41;
  x.a16 = 0x3061;
  x.a32 = 0x3031'3233;
  x.a64 = 0x6162'6364'6566'6768;
  x.b8 = 0x42;
  x.b16 = 0x3162;
  x.b32 = 0x3435'3637;
  x.b64 = 0x696a'636b'656c'676d;
  __int64_t y = 0xabcd'ef12;
  printf("mType Add: %p", &x);
  printf("mType Add: %d", x.a8);
  printf("mType Add: %d", x.a16);
  p_hexadecimal(y);
  printf("mType Add: %d", x.a32);
  printf("mType Add: %ld", x.a64);
  p_newline();
  p_decimal(y);
  return 0;
}

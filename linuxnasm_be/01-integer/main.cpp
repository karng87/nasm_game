#include <cstdint>
#include <stdio.h>
#include <inttypes.h>

// signed
// char
// int :: short int, int, long int

// unsigned
// unsigned char
// unsigned int => unsigned short int, unsigned int, unsigned logn int


extern "C" long int IntAdd(long int a, long int b, long int c, long int d, long int e, long int f);
extern "C" int64_t IntMul(int8_t a, int16_t b, int32_t c, int64_t d, int8_t e, int16_t f, int32_t g, int64_t h);

extern "C" void IntDiv(int64_t a, int64_t b, int64_t quo_rem_ab[2], int64_t c, int64_t d, int64_t quo_rem_cd[2]);

void addCpp(void){
  int64_t a = 100;
  int64_t b = 200;
  int64_t c = -300;
  int64_t d = 400;
  int64_t e = -500;
  int64_t f = 600;
  int64_t sum = IntAdd(a,b,c,d,e,f);
  printf("\nResults for IAdd\n");
  printf("a: %" PRId64  " b: %" PRId64 " c: %" PRId64 "\n", a, b,c);
  printf("d: %" PRId64  " e: %" PRId64 " f: %" PRId64 "\n", d, e,f);
  printf("sum: %" PRId64 "\n", sum);
}

void mulCpp(void){
  int8_t a = 2;
  int16_t b = -3;
  int32_t c = 8;
  int64_t d = 4;
  int8_t e = 3;
  int16_t f = -7;
  int32_t g = -5;
  int64_t h = 10;
  int32_t result = IntMul(a,b,c,d,e,f,g,h);
  printf("\nResults for IMul\n");
  printf("a: %" PRId8  " b: %" PRId16 " c: %" PRId32 " d: %" PRId64 "\n", a,b,c,d);
  printf("e: %" PRId8  " f: %" PRId16 " g: %" PRId32 " h: %" PRId64 "\n", e,f,g,h);
  printf("result: %" PRId32 "\n", result);
}

void divCpp(void){
  int64_t a = 102;
  int64_t b = 7;
  int64_t quo_rem_ab[2];
  int64_t c = 61;
  int64_t d = 9;
  int64_t quo_rem_cd[2];
  IntDiv(a,b,quo_rem_ab, c, d, quo_rem_cd);

  printf("\nResults for IDiv\n");
  printf("a: %" PRId64  " b: %" PRId64 " ", a, b);
  printf("quo: %" PRId64  " rem: %" PRId64 "\n", quo_rem_ab[0], quo_rem_ab[1]);
  printf("c: %" PRId64  " d: %" PRId64 " ", c, d);
  printf("quo: %" PRId64  " rem: %" PRId64 "\n", quo_rem_cd[0], quo_rem_cd[1]);
}

int main(int argc, char **argv){
  addCpp();
  mulCpp();
  divCpp();
  return 0;
}

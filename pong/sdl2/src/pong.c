#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#include <SDL2/SDL.h>

void my_random(){
  long t ;
  srand(time(&t));
  fprintf(stdout,"time : %ld\n",t);
  fprintf(stdout,"radom : %d\n",rand());
  fprintf(stdout,"radom() mod 10 + 1 => %d\n",rand()%10+1);
}
int main(){
  if (SDL_Init((SDL_INIT_VIDEO) != 0)) {
    fprintf(stdout,"Failed to initialize the SDL");
    return 1;
  }
  return 0;
}

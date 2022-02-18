#include <SDL2/SDL_events.h>
#include <SDL2/SDL_rect.h>
#include <SDL2/SDL_render.h>
#include <SDL2/SDL_stdinc.h>
#include <SDL2/SDL_surface.h>
#include <SDL2/SDL_timer.h>
#include <SDL2/SDL_video.h>
#include <stdio.h>
#include <unistd.h>
#include <SDL2/SDL.h>

int WIDTH = 640;
int HEIGHT = 480;
float BALL_SIZE = 10;
float BALL_SPEED = 120;

struct Ball {
  float x;
  float y;
  float dx;
  float dy;
  int size;
};


int main(){
struct Ball myball = {
  .x = WIDTH/2 - BALL_SIZE/2,
  .y = HEIGHT/2 - BALL_SIZE/2,
  .dx = BALL_SPEED,
  .dy = BALL_SPEED,
  .size = BALL_SIZE
};
  if(SDL_Init(SDL_INIT_VIDEO) !=0){
    fprintf(stderr,"Fail to initialize SDL: %s \n",SDL_GetError());
    exit(1);
  }
  SDL_Window * window = SDL_CreateWindow("Pong",SDL_WINDOWPOS_UNDEFINED,SDL_WINDOWPOS_UNDEFINED,WIDTH,HEIGHT,SDL_WINDOW_SHOWN);
  SDL_Renderer *renderer = SDL_CreateRenderer(window, -1,SDL_RENDERER_ACCELERATED|SDL_RENDERER_PRESENTVSYNC);
  SDL_SetRenderDrawColor(renderer,0,0,255,255);

  SDL_RenderClear(renderer);

  SDL_Rect ballRect = {
    .x = WIDTH/2 - myball.size/2 ,
    .y = HEIGHT/2 - myball.size/2,
    .w = myball.size,
    .h = myball.size,
  };
  SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
  SDL_RenderFillRect(renderer, &ballRect);

  SDL_RenderPresent(renderer);

  int quit = 0;

  Uint32 lastTicks = SDL_GetTicks();
  SDL_Event event;
  while (!quit){
    while(SDL_PollEvent(&event)){
      if(event.type == SDL_QUIT) quit = 1;
    }
    Uint32 curTicks = SDL_GetTicks();
    Uint32 dt = lastTicks - curTicks;
    lastTicks = curTicks;
  }

  SDL_Quit();
  return 0;
}

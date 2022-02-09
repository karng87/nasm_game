#include <SDL2/SDL_error.h>
#include <SDL2/SDL_events.h>
#include <SDL2/SDL_pixels.h>
#include <SDL2/SDL_render.h>
#include <SDL2/SDL_video.h>
#include <stdio.h>
#include <stdlib.h>
#include <SDL2/SDL.h>

#define N 3
#define SCREEN_WIDTH 640 
#define SCREEN_HEIGHT 480

int main(){
  if (SDL_Init(SDL_INIT_VIDEO) !=0){
    fprintf(stderr, "Could not initialize sdl2: %s\n",SDL_GetError());
    return EXIT_FAILURE;
  }

  SDL_Window *window = SDL_CreateWindow(
      "Procedual",
      100,100,
      640, 480,
      SDL_WINDOW_SHOWN);
  if(window ==NULL) {
    fprintf(stderr, "SDL_CreateWindow Error: %s\n",SDL_GetError()); 
    return EXIT_FAILURE;
  }
  SDL_Renderer *renderer = SDL_CreateRenderer(window, -1 , SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
  if(renderer == NULL){
    SDL_DestroyWindow(window);
    fprintf(stderr, "SDL_CreateRenderer Error: %s\n",SDL_GetError());
    return EXIT_FAILURE;
  }

  int quit = 0;
  SDL_Event pEvent;
  while (quit == 0){
    while(SDL_PollEvent(&pEvent)){
      switch (pEvent.type){
        case SDL_QUIT:
          quit = 1;
      }
    }
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
    SDL_RenderClear(renderer);
    //render and update game
    SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
    for(int i =1; i<N; ++i){
      SDL_RenderDrawLine(renderer, i*SCREEN_WIDTH/N, 0, i*SCREEN_WIDTH/N, SCREEN_HEIGHT);
      SDL_RenderDrawLine(renderer, 0, i*SCREEN_HEIGHT/N, SCREEN_WIDTH,i*SCREEN_HEIGHT/N);
    }
    SDL_RenderPresent(renderer);
  }
  SDL_DestroyWindow(window);
  SDL_Quit();
  return EXIT_SUCCESS;
}

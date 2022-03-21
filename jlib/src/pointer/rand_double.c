#include<stdio.h>
#include<stdlib.h>
#include<time.h>
double double_rand(){
  return 5*((double)rand() / (double)RAND_MAX);
}

int main(){
  //time_t secondsFromEpoch = time(NULL);
  srand(time(NULL));
  
  for(int i = 0; i< 50;i++){
    printf("%lf\n",double_rand());
  }
  return 0;
}

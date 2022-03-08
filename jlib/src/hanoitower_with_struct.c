#include<stdio.h>
#include<stdlib.h>
#include<limits.h>

struct Stack{
  unsigned int capacity;
  int top;
  int *disks;
};

void push(struct Stack *,int);
int pop(struct Stack*);
int main(){
  unsigned int n = 3;
  struct Stack *start, *destination, *waypoint;
  start = malloc(sizeof(struct Stack)*n);
  { start->capacity = n;
    start->top = -1;
    start->disks= malloc(start->capacity * sizeof(int));
  }
  destination= malloc(sizeof(struct Stack)*n);
  { destination->capacity = n;
    destination->top = -1;
    destination->disks= malloc(start->capacity * sizeof(int));
  }
  waypoint = malloc(sizeof(struct Stack)*n);
  { waypoint->capacity = n;
    waypoint->top = -1;
    waypoint->disks= malloc(start->capacity * sizeof(int));
  }
  return 0;
}
void push(struct Stack *stack, int item){
  if(stack->top == stack->capacity -1) return;
  *((stack->disks)+(++stack->top)) = item;
}
int pop(struct Stack*stack){
  if(stack->top == -1) return INT_MIN;
  return *(stack->disks + stack->top--);
}

void hanoi(int n, struct Stack *start, struct Stack *waypoint, struct Stack *destination){
  char s = 'S',d ='D',w ='W';
  if(n%2==0) d ^= w ^= d ^= w;
  int nfac = (1 << n) - 1;
  for (int i = 1; i<=nfac; i++){
    if(i%3==1){;}
    if(i%3==2){;}
    if(i%3==0){;}
  }
}

void movedisk(struct Stack *src, struct Stack *des){
  int srcT = pop(src);
  int desT = pop(des);
  if(srcT == INT_MIN){
    push(src,desT);
    printf("Move the disk %d from \'%c\' to \'%c\'\n",desT,d,s);
  }
}

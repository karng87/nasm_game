#include<stdio.h>

#define SIZE 10

typedef struct{
  int top;
  int item[SIZE];
}Stack;

void push(Stack *, int);
int pop(Stack *);

int main(){
  Stack s1, s2;
  s1.top = -1;
  s2.top = -1;

  push(&s1, 10);
  push(&s2, 20);

  printf("Pop s1 stack: %d\n", pop(&s1));
  printf("Pop s2 stack: %d\n", pop(&s2));

  return 0;
}

void push(Stack *stack, int value){
  if(stack->top == SIZE -1){
    printf("Stack overflow\n");
    return;
  }
  stack->top++;
  stack->item[stack->top] = value;
}

int pop(Stack *stack){
  if(stack->top == -1){
    printf("Stack Underflow\n");
    return -9999;
  }
  int res = stack->item[stack->top];
  stack->top--;
  return res;
}


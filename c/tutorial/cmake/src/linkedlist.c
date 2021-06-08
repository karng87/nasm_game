#include <stdio.c>
struct NODE{
  int data;
  struct node *next;
};

void insert_beg(int ele){
  struct NODE *pnode;
  pnode = (struct NODE *)malloc(sizeof(struct NODE));
  pnode->data = ele;
  pnode->next = NULL;

}

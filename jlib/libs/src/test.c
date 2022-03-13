#include<stdio.h>
#include<stdlib.h>
#include<jalgorithm.h>
#include<time.h>

#define bool char
#define true 0
#define false 0

struct node{
  int value;  // 0-4 byte 4~8byte(padding)
  struct node *next; //8~16 byte
};
void print_node(struct node *head){
  printf(" { ");
  while(head->next!=NULL){
    printf("\n\t(addr:%#lx ->val:%d ->next:%#lx),",head,head->value,head->next);
    head=head->next;
  }
  printf("\b \n }\n");
}
struct node* create_node(int val){
  struct node * result = malloc(sizeof(struct node));
  result->value = val;
  result->next = NULL;
  return result;
}
struct node* find_node(struct node* head,int fval){
  //head:0x..node -head:0x..node
  if(head->value==fval) return head;
  while(head->next != NULL){
    if((head->next)->value == fval) return head->next;
    head = head->next;
  }
  return NULL;
}

void freenode(struct node * head){
  if(head->next!=NULL){
    struct node * tmp = head->next;
    free(head);
    freenode(tmp);
  }
  else free(head);
}

struct node * insert_at_head(struct node **head, struct node *new){
  // head:0x..node tmp:0x..node _oldhead:0x..node _newhead:0x..node 
  new->next = *head;
  *head=new;
  return new;
}
void insert_after_node(struct node* node_to_insert_after,struct node* new_node){
  new_node->next = node_to_insert_after->next;
  node_to_insert_after->next=new_node;
}
bool remove_node(struct node ** head, struct node * to_del_node){
  // head<**node>:&originalhead<*node>:->originalhead<*node>:<&node>->node:data<int>,next<&node>->node:data<int>,next<&node>
  // head<rows-cols-node>
  // &node1 *next-> to_del_node(&node) *next-> &ndoe3
  if(*head == NULL) return false;
  struct node* tmp;
  struct node* tmp1;
  tmp1 = *head;
  tmp = (*head)->next;
  if(*head==to_del_node){free(head);*head=tmp; return true;}
  else{
    while(tmp != NULL && tmp != to_del_node){
      tmp1=tmp;
      tmp=tmp->next; 
    }
    if(tmp==NULL) return false;
    tmp1->next=tmp->next;
    free(tmp);
    return true;
  }
}

int main(){
  srand(time(NULL));
  struct node *tmp, *head=NULL;
  for(int i=0;i<10;i++){
    //tmp = createnode(rand()%10);
    tmp = create_node(i);
    insert_at_head(&head,tmp);
  }
  {int num=5;tmp = find_node(head,num);if(tmp!=NULL) printf("found search num(%d): addr:%p val:%d\n",num,tmp,tmp->value); else printf("not found num(%d) in node\n",num);}
  insert_after_node(tmp,create_node(77));
  print_node(head);
  print_node(tmp);
  remove_node(&head,tmp);
  print_node(head);
  freenode(head);
}

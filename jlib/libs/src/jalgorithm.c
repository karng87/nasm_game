#include <jbits.h>
#include <jalgorithm.h>
#include <stdio.h>
#include <stdlib.h>

/*** nPn ***/
static int dest_idx;
void _ja_permutation(int,char*,int,char**);

void ja_permutation(int swap_idx,char* src,int size,char** dest){
  dest_idx=0;
  printf ("before: dest_idx=%d\n",dest_idx);
  _ja_permutation(swap_idx,src,size,dest);
}
void _ja_permutation(int swap_idx, char* src,int size, char** dest){
  if(swap_idx==size){
    for(int i=0;i<size;i++){
      *(*(dest+dest_idx)+i) = *(src+i);
    }
    dest_idx++;
    return;
  }
  for(int i=swap_idx;i<size;i++){
    if(swap_idx!=i) jb_swap_c(src+swap_idx,src+i);
    _ja_permutation(swap_idx+1,src,size,dest);
    if(swap_idx!=i) jb_swap_c(src+swap_idx,src+i);
  }
}

/*** LinkedList ***/
void print_node_linkedList(struct node_linkedList *head){
  printf(" { ");
  while(head->next!=NULL){
    printf("\n\t(addr:%#lx ->val:%d ->next:%#lx),",head,head->value,head->next);
    head=head->next;
  }
  printf("\b \n }\n");
}
struct node_linkedList* create_node_linkedList(int val){
  struct node_linkedList * result = malloc(sizeof(struct node_linkedList));
  result->value = val;
  result->next = NULL;
  return result;
}
struct node_linkedList* find_node_linkedList(struct node_linkedList* head,int sVal){
  // <node*>head:NULL(0x100), => :<<int>value,<node*>next> nodeA :: <node*>((*head)->next):&node  =>  <<int>value, <node*>next>nodeB
  if(head->value==sVal) return head;
  while(head->next != NULL){
    if((head->next)->value == sVal) return head->next;
    head = head->next;
  }
  return NULL;
}

void free_node_linkedList(struct node_linkedList * head){
  if(head->next!=NULL){
    struct node_linkedList * tmp = head->next;
    free(head);
    free_node_linkedList(tmp);
  }
  else free(head);
}

struct node_linkedList * insert_at_head(struct node_linkedList **head, struct node_linkedList *new){
  // &head:(head+0)<node**>,(head+1)<node**>,.. 
  //     => (*(head+0)+0)<node*>,(*(head+0)+1))<node*>,...
  //        => *(*(head+0)+0)<node> 
  //        => *(*(head+0)+0)<node> 
  //     => (*(head+1)+0)<node*>,(*(head+1)+1))<node*> => <node*>*head::<node*>Ohead:&node => <node>**head::<node>*Ohead: <value,next>node
  // &a:a<int>

  // <node*>new: <node*>node, => <node>*new: <value,next>node
  new->next = *head;
  *head=new;
  return new;
}
void insert_after_node_linkedList(struct node_linkedList* node_linkedList_to_insert_after,struct node_linkedList* new_node_linkedList){
  new_node_linkedList->next = node_linkedList_to_insert_after->next;
  node_linkedList_to_insert_after->next=new_node_linkedList;
}
bool remove_node_linkedList(struct node_linkedList ** head, struct node_linkedList * to_del_node_linkedList){
  // head<**node_linkedList>:&originalhead<*node_linkedList>:->originalhead<*node_linkedList>:<&node_linkedList>->node_linkedList:data<int>,next<&node_linkedList>->node_linkedList:data<int>,next<&node_linkedList>
  // head<rows-cols-node_linkedList>
  // &node_linkedList1 *next-> to_del_node_linkedList(&node_linkedList) *next-> &ndoe3
  if(*head == NULL) return false;
  struct node_linkedList* tmp1;
  struct node_linkedList* tmp2;
  tmp1 = *head;
  tmp2 = (*head)->next;
  if(tmp1==to_del_node_linkedList){free(head);*head=tmp2; return true;}
  else{
    while(tmp1 != NULL && tmp1 != to_del_node_linkedList){
      tmp2=tmp1;
      tmp1=tmp1->next; 
    }
    if(tmp1==NULL) return false;
    tmp2->next=tmp1->next;
    free(tmp1);
    return true;
  }
}

#ifndef _H_jalgorithm_h
#define _H_jalgorithm_h

#define bool char
#define true 1
#define false 0

struct node_linkedList{
  int value;  // 0-4 byte 4~8byte(padding)
  struct node_linkedList *next; //8~16 byte
};

void ja_permutation(int,char*,int,char**);
void jnode_linkedList();

void print_node_linkedList(struct node_linkedList *head);
struct node_linkedList* create_node_linkedList(int val);
void free_node_linkedList(struct node_linkedList * head);

struct node_linkedList * insert_at_head(struct node_linkedList **, struct node_linkedList *);
void insert_after_node_linkedList(struct node_linkedList* node_linkedList_to_insert_after,struct node_linkedList* new_node_linkedList);
bool remove_node_linkedList(struct node_linkedList ** head, struct node_linkedList * to_del_node_linkedList);
#endif
 

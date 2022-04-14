#ifndef _H_JBIT_H
#define _H_JBIT_H
#include <defines.h>
void jb_swap(int*,int*);
void jb_swap_c(int*,int*);
b8 jb_odd(int);
b8 jb_even(int);
int jb_get_nth(int,int);
int jb_set_nth(int,int);
int jb_unset_nth(int,int);
int jb_toggle_nth(int,int);
int jb_turnoff_rightmost(int);
int jb_isolate_rightmost_1bit(int);
int jb_propagate_rightmost2right(int);
int jb_isolate_rightmost_0bit(int);
int jb_turnon_rightmost_0bit(int);

// powerset
void jb_powerset(int n,char* set,char** pset);
char** jb_ncr(int n,char* c, int r);
char** jb_npr(int n,char* p,int r);
// print
void jb_i2b(int);
#endif

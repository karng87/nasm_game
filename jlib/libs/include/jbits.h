#ifndef _H_JBIT_H
#define _H_JBIT_H

#include <stdbool.h>
struct jMatrix{int rows; int cols; double** cell;};
struct jData{int sizes; int used; int stride; void* p;};

void jb_swap(int*,int*);
void jb_swap_c(char*,char*);

bool jb_odd(int);
bool jb_even(int);

bool jb_is_set_nth(int,int);
int jb_set_nth(int,int);
int jb_unset_nth(int,int);
int jb_toggle_nth(int,int);
int jb_turnoff_rightmost(int);

int jb_rightmost_1bit(int x);
int jb_propagate_rightmost(int);
int jb_only_lastmost_zero_bit(int x);
int jb_turnon_rightmost_0bit(int);

// bits
void jb_powerset(int,char*,char**);

// print
void jb_i2b(int);
#endif

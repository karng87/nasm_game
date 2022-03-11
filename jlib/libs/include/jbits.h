#ifndef _H_JBIT_H
#define _H_JBIT_H

void jb_swap(int*,int*);
int jb_odd(int);
int jb_even(int);
int jb_is_nth(int,int);
int jb_set_nth(int,int);
int jb_unset_nth(int,int);
int jb_toggle_nth(int,int);
int jb_turnoff_rightmost(int);
int jb_isolate_rightmost_1bit(int);
int jb_propagate_rightmost2right(int);
int jb_isolate_rightmost_0bit(int);
int jb_turnon_rightmost_0bit(int);

// bits
void jb_powerset(int,char*,char**);

// print
void jb_i2b(int);
#endif

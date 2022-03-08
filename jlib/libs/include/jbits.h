#ifndef _H_JBIT_H
#define _H_JBIT_H

void j_swap(int*,int*);
int j_odd(int);
int j_even(int);
int j_is_nth(int,int);
int j_set_nth(int,int);
int j_unset_nth(int,int);
int j_toggle_nth(int,int);
int j_turnoff_rightmost(int);
int j_isolate_rightmost_1bit(int);
int j_propagate_rightmost2right(int);
int j_isolate_rightmost_0bit(int);
int j_turnon_rightmost_0bit(int);
#endif

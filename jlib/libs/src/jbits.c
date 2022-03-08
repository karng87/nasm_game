#include <jbits.h>

void j_swap(int* a, int* b){*a ^= *b ^= *a ^= *b;}
int j_odd(int x){return (x&1)?1:0;}
int j_even(int x){return !j_odd(x)?1:0;}
int j_is_nth(int x, int n){return (x & (1<<n)) ? 1:0;}
int j_set_nth(int x, int n){int y= x|(1<<n);return y;}
int j_unset_nth(int x, int n){int y = x & ~(1<<n);return y;}
int j_toggle_nth(int x, int n){int y = x ^ (1<<n);return y;}
int j_turnoff_rightmost(int x){int y = x & (x-1);return y;}
int j_isolate_rightmost_1bit(int x){int y = x &= (-(x));return y;}
int j_propagate_rightmost2right(int x){int y = (x |(x-1));return y;}
int j_isolate_rightmost_0bit(int x){int y = ~(x) & (x+1);return y;}
int j_turnon_rightmost_0bit(int x){int y = x | (x+1);return y;}


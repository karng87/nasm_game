#include<stdio.h>
#include<stdlib.h>
void basis_matrix(){
  system("tts \"space\"");
  system("tts \"subspace\"");
  system("tts \"set\"");
  system("tts \"subset\"");
  system("tts \"standard basis\"");
  system("tts \"span: vector space\"");
  system("tts \"linearly independent set\"");
  system("tts \"linear independent\"");
  system("tts \"linear combination\"");

  printf("vector space: (V,+,\\dot) := (Field)");
  printf("     V: V is set");
  printf("     +: V x V -> V function");
  printf(" \\dot: V x V -> V function");
  printf(" Axiom: (V,+) is 아벨군(결합,항등원,역원,교환)");
  printf("      : (V,+,.) is 가군(결합,항등원,분배)");
  printf("linear independent: 선형독립");
  printf("      : x_1\\hat{e_1}+..+x_n\\hat{e_n} != \\vec{0}");
  printf("basis : 기저 in a Vector sapce(V), V ~\\in 0 space");
  printf("      : B_e={\\hat{e_1},..,\\hat{e_n}}");
  printf("      : B_b={\\hat{v'_1},..,\\hat{v'_n}}");
  printf("      : B,B' 선형 독립이어야 핟다.");
  printf("      : B,B' 그 공간안의 원소로만 이루어져 있어야 한다.");
  printf("linear combination: 선형결합");
  printf("\n<< change of basis >>\n");
  printf("std unit vector: E={\\hat{e_1},\\hat{e_2},\\hat{e_3}}\n");
  printf("  \\vec{u}   : (a_1,a_2,a_3)_E\n");
  printf("  unit vector: B={\\hat{v_1},\\hatt{v_2},\\hat{v_3}}_E\n");
  printf("  \\vec{v}   : (b_1,b_2,b_3)_B\n");
  printf("  unit vector: B'={\\hat{v'_1},\\hatt{v'_2},\\hat{v'_3}}_B\n");
  printf("  \\vec{v'}  : (b'_1,b'_2,b'_3)_B'\n");
  printf(" \tE: [1    0     0]\n \t   [0    1     0]\n \t   [0    0     1]\n \n \tB: [v_1  0     0  ]\n \t   [0    v_2   0  ]\n \t   [0    0     v_3]\n \n \tB':[v'_1 0     0   ]\n \t   [0    v'_2  0   ]\n \t   [0    0     v'_3]\n");


}
int main(){
  basis_matrix();
  return 0;
}
/*
   
*/
/*
   [1 0 0] [a_1]  <= [v_11 v_12 v_13] [b_1] <= [v'_11 v'_12 v'_13] [b'_1]
   [0 1 0] [a_2]     [v_21 v_22 v_23] [b_2]    [v'_21 v'_22 v'_23] [b'_2]                     [b'_2] 
   [0 0 1] [a_3]     [v_31 v_32 v_33] [b_3]    [v'_31 v'_32 v'_33] [b'_3]                     [b'_3] 

I[e^1 e^2 e^3](E) [a_1] <= B[v^1 v^2 v^3](E) [b_1] <= B'[v'^1 v'^2 v'^3](B) [b'_1] 
                  [a_2]                      [b_2]                          [b'_2] 
                  [a_3]                      [b_3]                          [b'_3] 

   [e^1 e^2 e^3] [a_1] => E_[v^1 v^2 v^3]^{-1} [b_1] <= [v'^1 v'^2 v'^3]_B [b'_1] 
                 [a_2]                    [b_2]                       [b'_2] 
                 [a_3]                    [b_3]                       [b'_3] 
    => [v_1 v_2 v_3] [b_1] <= [e_1 e_2 e_3] [a_1] => [v_1 v_2 v_3] [b_1] => [v'_1 v'_2 v'_3] [b'_1] 
                     [b_2]              [a_2]                  [b_2]                     [b'_2] 
                     [b_3]              [a_3]                  [b_3]                     [b'_3] 
*/

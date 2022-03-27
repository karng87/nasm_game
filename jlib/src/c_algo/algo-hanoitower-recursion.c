#include <stdio.h>

void hanoitower(int n, char from, char mid, char to);
int main(){
  hanoitower(3,'S','W','D');
  return 0;
}
void hanoitower(int n, char start, char waypoint, char dest){
  printf("\n***> entering hanoi(%d,%c,%c,%c) ",n,start,waypoint,dest);
  if(n==0) {
    printf("\n<*** <0th :n(%d) void return> ***\n",n);
    return;
  }
  printf("\n\t<1st:n(%d)> call h(%d,출발점(%c), 경유지(%c), 목적지(%c)) --",n,n-1,start,dest,waypoint);
  hanoitower(n-1,start,dest,waypoint);

  printf("\n\t<2nd:n(%d)> Moveing %c ===> %c\t",n,start,dest);

  printf("\n\t<3rd:n(%d)> call h(%d,출발점(%c), 경유지(%c), 목적지(%c)) --",n,n-1,waypoint,start,dest);
  hanoitower(n-1,waypoint,start,dest);
  printf("<*** <4th end call: hanoi(%d,%c,%c,%c) void return\n",n,start,waypoint,dest);
  return;
}
/** tree **
 node (root internal leaf)
 edge (depth)
 level (transverse level)
****/
/*** Inorder tree search *** 
  left -> root(In) -> right
    - Preorder tree search => root(Pre) -> left -> right
    - Postorder tree search =>  left -> right -> root(Post)
  node leaf 
****/

/********
  context:: n=3 start={'S'} waypoint={'W'} dest={'D'}
  edge -> root -> edge (inorder)
----------------------------
call: f(3, 1:'S', 2:'W', 3:'D')
  0l{ edge||f(2, 1:'S', 3:'D', 2:'W')|| node(print [3] 1:'S'-> 3:'D') edge||f(2, 2:'W', 1:'S', 3:'D')|| }

0l-edge: f(2,1:'S',2:'D',3:'W') -> call 0l-node 
  1l{edge||f(1, 1:'S', 3:'W', 2:'D')|| node(print [2] 1:'S'-> 3:'W') edge||f(1, 2'D', 1'S', 3'W')|| }

1l-edge: f(1,1:'S',2:'W',3:'D') => call 1l-node
  2l{edge||f(0, 1:'S', 3:'D', 2:'W')|| node(print [1] 1:'S'-> 3:'D') edge||f(0, 2:'W', 1:'S', 3:'D')|| }

2l-edge: f(0,1:'S',2:'D',3:'W') => call 2l-node
  3l{edge||f(0, 1:'S', 3:'W', 2:'D')|| node(print [0] 1:'S'-> 3:'W') edge||f(0, 2:'D', 1:'S', 3:'W')|| }
30-edge: f(0, 1:'S', 2:'W', 3:'D')> => call 3l-node
  leaf{return;} 

*************/
/********
  context:: n=3 start={'S'} waypoint={'W'} dest={'D'}
  edge -> root -> edge (inorder)
----------------------------
call: f(3,{1:'S'},{2:'W'},{3:'D'})
  0l{ edge|-f(2,1:'S',3:'D',2:'W')-| _node(print [3] 1:'S'-> 3:'D') edge|-f(2,2:'W',1:'S',3:'D')-| }

0l-edge: f(2,1:'S',2:'D',3:'W') -> call 0l-node 
  1l{edge||-f(1,1:'S',3:'W',2:'D')-|| __node(print [2] 1:'S'-> 3:'W') edge||-f(1,2'D',1'S',3'W')-|| }

1l-edge: f(1,1:'S',2:'W',3:'D') => call 1l-node
  2l{edge||||-f(0,1:'S',3:'D',2:'W')-|||| ____node(print [1] 1:'S'-> 3:'D') edge||||-f(0,2:'W',1:'S',3:'D')-|||| }

2l-edge: f(0,1:'S',2:'D',3:'W') => call 2l-node
  3l{edge||||||||-f(0,1:'S',3:'W',2:'D')-|||||||| node(print [0] 1:'S'-> 3:'W') edge||||||||-f(0,2:'D',1:'S',3:'W')-|||||||| }
30-edge: f(0,1:'S',2:'W',3:'D')> => call 3l-node
  leaf{return;} 

*************/
/********
  context:: n=3 start={'S'} waypoint={'W'} dest={'D'}
  edge -> root -> edge (inorder)
----------------------------
call: f(3,{1:'S'},{2:'W'},{3:'D'})
  0l{ edge-f(2,1:'S',3:'D',2:'W')- node(print [3] 1:'S'-> 3:'D') edge-f(2,2:'W',1:'S',3:'D')- }

0l-edge: f(2,1:'S',2:'D',3:'W') -> call 0l-node 
  1l{edge-f(1,1:'S',3:'W',2:'D')- node(print [2] 1:'S'-> 3:'W') edge-f(1,2'D',1'S',3'W')- }

1l-edge: f(1,1:'S',2:'W',3:'D') => call 1l-node
  2l{edge-f(0,1:'S',3:'D',2:'W')- node(print [1] 1:'S'-> 3:'D') edge-f(0,2:'W',1:'S',3:'D')- }

2l-edge: f(0,1:'S',2:'D',3:'W') => call 2l-node
  3l{edge-f(0,1:'S',3:'W',2:'D')- node(print [0] 1:'S'-> 3:'W') edge||||||||-f(0,2:'D',1:'S',3:'W')-|||||||| }
30-edge: f(0,1:'S',2:'W',3:'D')> => call 3l-node
  leaf{return;} 

*************/

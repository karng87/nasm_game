// 1) objects for compile
//      gcc -c hello.c world.c
//
// 2) the exeutable file for linking  
//      gcc -shared -o libworld.so world.o
//      gcc -shared -o libhello.so hello.o
//          gcc test.c -lworld -lhello -L.
//
//      gcc -shared -o libhw hello.o world.o 
//
//      r-path for excuting 
//          gcc test.c -lhw -L. -Wl,rpath=.
//
// 3) a excuting for LD_LIRBRRY_PATH
//      LD_LIBARARY_PATH=. ./a.out
//
// ./a.out
//
// gcc test.c hello.o world.o
void main(){
  hello();
}

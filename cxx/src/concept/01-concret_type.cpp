#include <iostream>

struct Concret{int i; double d;};
template <typename T> struct NonConcret{T m,n; NonConcret(T t1, T t2):m{t1},n{t2}{}};

template <typename T> struct DeductionStruct{T v;};
// class template argument dedution guide
template <typename T> DeductionStruct(T t) -> DeductionStruct<T>;

template <typename T> struct Div1{T a,b; T operator()(){return a/b;}};
template <typename T> Div1(T t1, T t2)-> Div1<T>;
int main(){
  Concret cs {3,3.14};
  NonConcret ns{3.14,2.791828};
  DeductionStruct ds{3.1415};
  Div1 divf{2.3,0.0};
  Div1 divi{3,0};
  
  std::cout << cs.i << std::endl;
  std::cout << ns.m << std::endl;
  std::cout << ds.v << std::endl;
  std::cout << divf() << std::endl;
  std::cout << divi() << std::endl;
}

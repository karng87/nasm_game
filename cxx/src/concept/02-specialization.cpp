#include <iostream>

// primary class
template <typename T> struct Div{T a,b; T operator()(){return a/b;}};
// class template argument deduction
template <> struct Div<int>{int a,b; auto operator()(){if (b!=0) return a/b; else throw std::runtime_error("divided by zero");}};
// specialization := explicit instanciation
template <typename T> Div (T t1, T t2) -> Div<T>;

int main(){
  Div divf{2.3, 0.0};
  Div divi{3,0};
  
  std::cout << divf() << std::endl;
  std::cout << divi() << std::endl;
  return 0;
}

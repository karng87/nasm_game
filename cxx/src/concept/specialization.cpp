#include <iostream>

// primary class
template <typename T> struct Div{T a,b; T operator()(){return a/b;}};
// template argument deduction
template <typename T> Div(T t1, T t2)-> Div<T>;
// specialization := explicit instanciation
template <> struct Div<int> {int a,b; auto operator()(){if (b!=0) return a/b; else throw std::runtime_error("Div");};

int main(){
  Div divf{2.3, 0.0};
  Div divi{3,0};
  
  std::cout << divf() << std::endl;
  std::cout << divi() << std::endl;
}

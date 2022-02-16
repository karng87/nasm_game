#include <iostream>

template <typename T> struct Div{T t1,t2; auto operator()(){return t1/t2;}};
// explict instanciation
template struct Div<double>;
// explict instanciation \implied specialization
//template<> struct Div<double>{double t1,t2; auto operator()(){return t1/t2;}};
template <typename T> Div(T t1, T t2) -> Div<T>;

int main(){
  Div d1{1.0, 0.0};
  Div d2{1,2};
  std::cout << d1() << std::endl;
  std::cout << d2() << std::endl;
  return 0;
}

#include <iostream>
template <typename T, typename S> struct is_same{constexpr static bool value = false;};
template <typename T> struct is_same<T,T>{constexpr static bool value = true;};
template <typename T,typename S> constexpr bool is_same_v = is_same<T,S>::value;

/* prototype parameter := P \iff curry function \in concept */
template <typename P, typename S> concept is_same_c = is_same<P,S>::value;

auto sum (is_same_c<int> auto a , is_same_c<double> auto b){return a+b;}

int main(){
  std::cout << is_same_v<int,int> << std::endl;
  std::cout << is_same_c<int,double> << std::endl;
  std::cout << sum(2,3.4) << std::endl;
  is_same_c<int> auto a = (2+3);
  std::cout << a << std::endl;
  return 0;
}

#include <iostream>
template <typename T, typename S> struct is_same{constexpr static bool value = false;};
template <typename T> struct is_same<T,T>{constexpr static bool value = true;};
template <typename T,typename S> constexpr bool traits_is_same = is_same<T,S>::value;

/* prototype parameter := P \iff curry function \in concept */
template <typename P, typename S> concept concept_is_same = is_same<P,S>::value;

auto sum (concept_is_same<int> auto a , concept_is_same<double> auto b){return a+b;}

int main(){
  std::cout << traits_is_same<int,int> << std::endl;
  std::cout << concept_is_same<int,double> << std::endl;
  std::cout << sum(2,3.4) << std::endl;
  concept_is_same<int> auto a = (2+3);
  std::cout << a << std::endl;
  return 0;
}

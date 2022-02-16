#include <iostream>
template<typename P, typename ... Types>
concept all_same_c = (std::same_as<P,Types> && ...);

namespace head_differ{
  template<typename P, typename... Types>
  concept head_differ_c = ( !std::same_as<P,Types> && ...);

  template<typename P, typename... Types>
  consteval bool isAllDiffer(){
    if constexpr (sizeof...(Types) == 0){
      return head_differ_c<P>;}
    else {
      return (head_differ_c<P,Types...> && &isAllDiffer<Types...>);}
  }
}// end of head_differ namespace
template<typename P, typename ... Types>
concept all_differ_c = head_differ::isAllDiffer<P, Types...>();

template<typename P, typename ... Types>
concept some_differ_c = (!all_same_c<P, Types...> && !all_differ_c<P, Types...>);

template<typename P, typename ... Types>
requires all_same_c<P,Types...>
auto sum(P p, Types... args){
  std::cout << "requires all _same_c" << std::endl;
  return (p + ... + args);
}
template<typename P, typename ...Qs>
requires all_differ_c<P,Qs...>
auto sum(P p, Qs... qs){
  std::cout << "requires all_differ_c" << std::endl;
  return (p + ... + qs);
}
template<typename P, typename ... Qs>
requires some_differ_c<P,Qs...>
auto sum(P p, Qs... qs){
  std::cout << "requires some_differ_c" << std::endl;
  return (p + ... + qs);
}

int main(){
  std::cout << sum(1,2,3,4,5) << std::endl;
  std::cout << sum(1.1,2,3.0f) << std::endl;
  std::cout << sum(1.1,2,3.1,3.0f) << std::endl;
  return 0;
}

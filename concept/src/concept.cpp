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
      return (head_differ_c<P,Types...> && isAllDiffer<Types...>);}
  }
}// end of head_differ namespace
template<typename P, typename ... Types>
concept all_differ_c = head_differ::isAllDiffer<P, Types...>();

template<typename P, typename ... Types>
concept some_differ_c = (!all_same_c<P, Types...> && !all_differ_c<P, Types...>);

int main(){
  return 0;
}

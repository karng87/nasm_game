#include <iostream>

/* prototype parameter */

// {type trait} primary class template
template<typename T, typename S> struct is_same{constexpr static bool value =false;};
// = template<typename T> struct is_same:std::false_type{};
// specialization
template<typename T> struct is_same<T,T>:std::true_type{};
template<typename T,typename S> constexpr bool is_same_v = is_same<T,S>::value;

int main(){
  std::cout << is_same_v<int,short> << std::endl;
  std::cout << is_same_v<int,int> << std::endl;
  return 0;
}

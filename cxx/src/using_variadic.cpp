#include <iostream>
#include <type_traits>
#include <vector>

auto sumOfVector(auto... args){
  std::vector v{args...};
  //using type_ve = std::remove_cvref_t<decltype(v[0])>; // remove constant volatile
  using type_ve = typename decltype(v)::value_type;
  type_ve ve {};
  for (auto& i : v){
    ve += i;
  }
  return ve;
}
int main(){
  auto s = sumOfVector(1,2,3,4,5);
  std::cout << s << std::endl;
  return 0;
}

#include <iostream>

auto sum(auto start, auto end){
  using type_x = decltype(start);
  using type_y = decltype(end);
  type_x s{};
  for(type_y i = start; i <= end; i++){
    s += i;
  }
  return s;
}
int main(){
  auto s = sum(1,11);
  auto sf = sum(1.5,11.5);
  std::cout << s << " " << sf << std::endl;
  return 0;
}

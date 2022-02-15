#include <iostream>

auto foldr(auto ... args){
  return (args + ...);
}
auto foldl(auto ... args){
  return (args + ...);
}

auto foldrr (auto arg, auto ... args){
  return (args + ... + arg);
}
auto foldll (auto arg, auto ... args){
  return (arg + ... + args);
}
int main(){
  auto rr = foldr(1,2,3,4.5,5,6);
  auto ll = foldl(1,2,3,4,5.5,6);
  std::cout << rr << std::endl;
  std::cout << ll << std::endl;
  return 0;
}

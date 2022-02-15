#include <iostream>

auto foldr(auto ... args){
  return (args + ...); // := args + (arg2 + arg3)
}
auto foldl(auto ... args){
  return (... + args ); // := (arg1 + arg2) + args
}

auto foldrr (auto arg, auto ... args){
  return (args + ... + arg); // := args + ( arg2 + acc)
}
auto foldll (auto arg, auto ... args){
  return (arg + ... + args); // := (acc + arg1) + args
}
int main(){
  auto rr = foldr(1,2,3,4.5,5,6);
  auto ll = foldl(1,2,3,4,5.5,6);
  std::cout << rr << std::endl;
  std::cout << ll << std::endl;
  return 0;
}

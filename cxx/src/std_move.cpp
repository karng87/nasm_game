#include <iostream>

int main(){
  int a = 5;
  int& b = a;
  int& bb = b;
  int&& c = 9;
  int& bbb = c;
  int&& cc = a;
  int&& ccc  = b;
  int&& cccc  = bb;
  int&& ccccc  = c;
  std::cout << a << " b:" << b << " c:" << c << std::endl;
}

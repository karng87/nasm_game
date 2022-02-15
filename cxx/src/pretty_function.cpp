#include <iostream>
#include <vector>

template <typename T>
void prettyFunc (T n){
#ifdef __FUNC_SIG__
  std::cout << __FUNC_SIG__ << std::endl;
#endif
  std::cout << __PRETTY_FUNCTION__ << std::endl;
}

int main(){
  const int n = 4;
  prettyFunc(n);
  prettyFunc<const int>(3);
  int arr[]{1,2};
  prettyFunc(arr);
  prettyFunc<int []>(arr);
  std::vector<int> v{1,2};
  prettyFunc(v);
  prettyFunc<std::vector<int>>(v);
  return 0;
}

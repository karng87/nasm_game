#include <iostream>

// P := prototype parameter /sim Curried function
template <typename C, typename... Ts> concept concept_allowable = (std::same_as<C,Ts> || ...);
template <typename P> concept concept_float = concept_allowable<P, float,double>;
template <typename P> concept concept_int = concept_allowable<P,short, int, long long>;
template <typename P> concept concept_rval_int = concept_int<std::remove_cvref_t<P>>;
template <typename P> concept concept_rval_float = concept_float<std::remove_cvref_t<P>>;

auto sum_ri(concept_rval_int auto&& ... args ){return (args + ...);}
auto mul_rf(concept_rval_float auto&& ... args ){return (args * ...);}


int main(){
  std::cout << sum_ri(3,4,5ll)<< std::endl;
  std::cout << mul_rf(3.0,.3,.3f)<< std::endl;
  return 0;
}

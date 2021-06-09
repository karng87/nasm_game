//  # Step 1: Compile with coverage enabled.
// % clang++ -fprofile-instr-generate -fcoverage-mapping foo.cc -o foo

//  # Step 2: Run the program.
// % LLVM_PROFILE_FILE="foo.profraw" ./foo

//  # Step 3(a): Index the raw profile.
// % llvm-profdata merge -sparse foo.profraw -o foo.profdata

//  # Step 3(b): Create a line-oriented coverage report.
// % llvm-cov show ./foo -instr-profile=foo.profdata

//  # Step 3(c): Create a coverage summary.
// % llvm-cov report ./foo -instr-profile=foo.profdata
//
// To compile code with coverage enabled pass
// -fprofile-instr-generate -fcoverage-mapping
#define BAR(X) ((X) || (X))
template <typename T> void foo(T x){
  for (unsigned I=0; I<10; ++I){BAR(I);}
}

int main(){
  foo<int>(0);
  foo<float>(0);
  return 0;
}

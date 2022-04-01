#pragma once

// Inlining
#if defined(__clang__) || defined(__gcc__)
  #define INLINE __attribute__((always_inline)) inline
  #define NOINLINE __attribute__((noinline))

#elif defined(_MSC_VER)
  #define INLINE __forceinline
  #define NOINLINE __declspec(noinline)
#else
  #define INLINE static inline
  #define NOINLINE
#endif


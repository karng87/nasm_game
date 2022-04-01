#pragma once

// Platform detection
#if defined(WIN32) || defined(_WIN32) || defined(__WIN32__)
  #define WIN 1
  #ifndef _WIN64
    #error "64-bit is required on Windows!"
  #endif

// Linux OS
#elif defined(__linux__) || defined(__gnu_linux__)
  #define LINUX 1
  #if defined(__ANDROID__)
    #define ANDROID 1
  #endif

// Catch anything not caught by the above.
#elif defined(__unix__)
  #define UNIX 1

// Posix
#elif defined(_POSIX_VERSION)
  #define POSIX 1

// Apple platforms
#elif __APPLE__
  #define APPLE 1
  #include <TargetConditionals.h>
// iOS Simulator
  #if TARGET_IPHONE_SIMULATOR
      #define IOS 1
      #define OS_SIMULATOR 1
// iOS device
  #elif TARGET_OS_IPHONE
      #define IOS 1
// Other kinds of Mac OS
  #elif TARGET_OS_MAC
  #else
      #error "Unknown Apple platform"
  #endif
#else
    #error "Unknown platform!"
#endif


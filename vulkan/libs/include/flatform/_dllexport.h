#pragma once 

// Exports
#ifdef EXPORT
  #ifdef _MSC_VER
    #define API __declspec(dllexport)
  #else
    #define API __attribute__((visibility("default")))
  #endif

// Imports
#else
/** @brief Import/export qualifier */
  #ifdef _MSC_VER
    #define API __declspec(dllimport)
/** @brief Import/export qualifier */
  #else
    #define API
  #endif
#endif


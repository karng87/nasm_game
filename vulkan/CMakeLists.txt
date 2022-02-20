cmake_minimum_required(VERSION 3.13)
project(FoE-Engine CXX)


include(cmake/cxx.cmake)
include(cmake/formatting.cmake)
cxx_20()
# cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
add_subdirectory(src)

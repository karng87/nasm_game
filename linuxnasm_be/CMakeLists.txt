# https://github.com/Ybalrid/cmake-cpp-nasm
cmake_minimum_required(VERSION 3.14)
project (hello-nasm)

set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 20)

enable_language(ASM_NASM)

set(CMAKE_ASM_NASM_FLAGS_DEBUG "-g -Fdwarf")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fno-omit-frame-pointer -fsanitize=address")

set(CMAKE_ASM_NASM_LINK_EXECUTABLE "ld <CMAKE_ASM_NASM_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")
#if(APPLE)
#	#Add leading underscore when building macho64 object files
#	string(APPEND CMAKE_ASM_NASM_FLAGS "--prefix _")
#endif(APPLE)


#If the goal is to interact with C++ code and assembly code, calling convention
#changes between platform, some adjustment on the assembly code is required.

#The following will pre-define a NASM macro "WIN32". This permit to conditionally assemble
#code in the following manner :
#  %ifdef WIN32
#     ;code for Windows ABI
#  %else
#     ;code for System V AMD64 ABI
#  %endif
if(WIN32)
	string(APPEND CMAKE_ASM_NASM_FLAGS "-dWIN32=1")
endif(WIN32)

#Make a EXE with cpp and asm files
add_executable(hello-nasm src/asm/hello.asm)
add_subdirectory(01-integer)
add_subdirectory(02-memory)


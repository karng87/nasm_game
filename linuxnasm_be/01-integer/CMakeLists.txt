# https://github.com/Ybalrid/cmake-cpp-nasm

cmake_minimum_required(VERSION 3.14)
project (integer-cpp-nasm)

#Make a EXE with cpp and asm files
add_executable(integer-cpp-nasm main.cpp integerArithmetic.asm)

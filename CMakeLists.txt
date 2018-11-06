cmake_minimum_required(VERSION 3.11)
message(STATUS "Starting with CMake version ${CMAKE_VERSION}")
project(llvm-experiments VERSION 1.0 LANGUAGES C CXX)

add_subdirectory(llvm-first-step)
add_subdirectory(llvm-front-clang-demo)
add_subdirectory(llvm-front-clang-simple-frontend)
add_subdirectory(llvm-ir-simple-generator)
add_subdirectory(llvm-unit-tests)

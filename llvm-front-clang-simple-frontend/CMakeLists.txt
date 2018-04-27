cmake_minimum_required(VERSION 3.11)
message(STATUS "Starting with CMake version ${CMAKE_VERSION}")
project(llvm-front-clang-simple-frontend VERSION 1.0 LANGUAGES C CXX)
message(STATUS "Configure project: ${CMAKE_PROJECT_NAME}")

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
set(CMAKE_CXX_EXTENSIONS OFF)

if(NOT DEFINED LLVM_INSTALL_PREFIX)
	message(FATAL_ERROR "The build is called without LLVM_INSTALL_PREFIX")
else()
    message(STATUS "LLVM_INSTALL_PREFIX: ${LLVM_INSTALL_PREFIX}")
endif()

# Import Clang libraries
include(${LLVM_INSTALL_PREFIX}/lib/cmake/clang/ClangConfig.cmake)

# Import LLVM libraries
include(${LLVM_INSTALL_PREFIX}/lib/cmake/llvm/LLVMConfig.cmake)

# Let all targets use LLVM's headers
include_directories(
    PRIVATE
        "${LLVM_INCLUDE_DIR}"
)

add_executable(simple-frontend)

target_sources(simple-frontend
    PRIVATE
        "${CMAKE_CURRENT_SOURCE_DIR}/simple-frontend.cpp"
)

target_link_libraries(simple-frontend
    PRIVATE
        clangFrontend
)

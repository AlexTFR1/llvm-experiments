cmake_minimum_required(VERSION 3.11)
message(STATUS "Starting with CMake version ${CMAKE_VERSION}")
project(llvm-front-clang-demo VERSION 1.0 LANGUAGES C CXX)
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

# Configure the build
configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/include/config/global-config.h.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/include/config/global-config.h
)

# Let all targets use LLVM's headers
include_directories(diagnostics-c
    PRIVATE
        "${LLVM_INCLUDE_DIR}"
        "${CMAKE_CURRENT_BINARY_DIR}/include"
)

# Exploit the libclang C interface
add_executable(diagnostics-c)

target_sources(diagnostics-c
    PRIVATE
        "${CMAKE_CURRENT_SOURCE_DIR}/diagnostics-c.cpp"
)

target_link_libraries(diagnostics-c
    PRIVATE
        libclang
        LLVMCore
)

# Exploit the libclang C interface
add_executable(lexer-c)

target_sources(lexer-c
    PRIVATE
        "${CMAKE_CURRENT_SOURCE_DIR}/lexer-c.cpp"
)

target_link_libraries(lexer-c
    PRIVATE
        libclang
        LLVMCore
)

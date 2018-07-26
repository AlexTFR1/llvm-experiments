cmake_minimum_required(VERSION 3.11)
message(STATUS "Starting with CMake version ${CMAKE_VERSION}")
project(llvm-first-step VERSION 1.0 LANGUAGES C CXX)
message(STATUS "Configure project: ${CMAKE_PROJECT_NAME}")

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
set(CMAKE_CXX_EXTENSIONS OFF)

#get_filename_component(LLVMPath ${CMAKE_CXX_COMPILER} DIRECTORY CACHE)
if(NOT DEFINED LLVM_INSTALL_PREFIX)
    message(FATAL_ERROR "The build is called without LLVM_INSTALL_PREFIX")
else()
    message(STATUS "LLVM_INSTALL_PREFIX: ${LLVM_INSTALL_PREFIX}")
endif()

add_library(LLVMDemangle STATIC IMPORTED)

set_target_properties(LLVMDemangle PROPERTIES
    IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
    IMPORTED_LOCATION "${LLVM_INSTALL_PREFIX}/lib/LLVMDemangle.lib"
)

add_library(LLVMSupport STATIC IMPORTED)

set_target_properties(LLVMSupport PROPERTIES
    INTERFACE_LINK_LIBRARIES "psapi;shell32;ole32;uuid;advapi32;LLVMDemangle"
)

set_target_properties(LLVMSupport PROPERTIES
    IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C;CXX"
    IMPORTED_LOCATION "${LLVM_INSTALL_PREFIX}/lib/LLVMSupport.lib"
)

add_library(LLVMCore STATIC IMPORTED)

set_target_properties(LLVMCore PROPERTIES
    INTERFACE_LINK_LIBRARIES "LLVMBinaryFormat;LLVMSupport"
)

set_target_properties(LLVMCore PROPERTIES
    IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
    IMPORTED_LOCATION "${LLVM_INSTALL_PREFIX}/lib/LLVMCore.lib"
)

add_library(LLVMBinaryFormat STATIC IMPORTED)

set_target_properties(LLVMBinaryFormat PROPERTIES
    INTERFACE_LINK_LIBRARIES "LLVMSupport"
)

set_target_properties(LLVMBinaryFormat PROPERTIES
    IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
    IMPORTED_LOCATION "${LLVM_INSTALL_PREFIX}/lib/LLVMBinaryFormat.lib"
)

add_library(LLVMBitReader STATIC IMPORTED)

set_target_properties(LLVMBitReader PROPERTIES
    INTERFACE_LINK_LIBRARIES "LLVMCore;LLVMSupport"
)

set_target_properties(LLVMBitReader PROPERTIES
    IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
    IMPORTED_LOCATION "${LLVM_INSTALL_PREFIX}/lib/LLVMBitReader.lib"
)

add_executable(llvmhello)

target_sources(llvmhello
    PRIVATE
        "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp"
)

target_include_directories(llvmhello
    PRIVATE
        "${LLVM_INSTALL_PREFIX}/include"
)

target_link_libraries(llvmhello
    PRIVATE
        LLVMBitReader
)

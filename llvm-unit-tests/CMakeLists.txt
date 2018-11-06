cmake_minimum_required(VERSION 3.11)
message(STATUS "Starting with CMake version ${CMAKE_VERSION}")
project(llvm-unit-tests VERSION 1.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
set(CMAKE_CXX_EXTENSIONS OFF)

# On non-Debug builds cmake automatically defines NDEBUG, so we
# explicitly undefine it:
if(NOT uppercase_CMAKE_BUILD_TYPE STREQUAL "DEBUG")
	add_definitions(-UNDEBUG)
	# Also remove /D NDEBUG to avoid MSVC warnings about conflicting defines.
	foreach(flags_var_to_scrub
			CMAKE_CXX_FLAGS_RELEASE
			CMAKE_CXX_FLAGS_RELWITHDEBINFO
			CMAKE_CXX_FLAGS_MINSIZEREL
			CMAKE_C_FLAGS_RELEASE
			CMAKE_C_FLAGS_RELWITHDEBINFO
			CMAKE_C_FLAGS_MINSIZEREL)
		string(REGEX REPLACE "(^| )[/-]D *NDEBUG($| )" " "
				"${flags_var_to_scrub}" "${${flags_var_to_scrub}}")
	endforeach()
endif()

if(NOT DEFINED LLVM_INSTALL_PREFIX)
	message(FATAL_ERROR "The build is called without LLVM_INSTALL_PREFIX")
else()
	message(STATUS "LLVM_INSTALL_PREFIX: ${LLVM_INSTALL_PREFIX}")
endif()

# Import LLVM libraries
include(${LLVM_INSTALL_PREFIX}/lib/cmake/llvm/LLVMConfig.cmake)

# Let all targets use LLVM's headers
include_directories(
	PRIVATE
		"${LLVM_INCLUDE_DIR}"
)

include(CTest)

if (CMAKE_VERSION VERSION_LESS 3.2)
	set(UPDATE_DISCONNECTED_IF_AVAILABLE "")
else()
	set(UPDATE_DISCONNECTED_IF_AVAILABLE "UPDATE_DISCONNECTED 1")
endif()

include(DownloadProject.cmake)
download_project(PROJ		googletest
		GIT_REPOSITORY      https://github.com/google/googletest.git
		GIT_TAG             master
		${UPDATE_DISCONNECTED_IF_AVAILABLE}
)

# Prevent GoogleTest from overriding our compiler/linker options
# when building with Visual Studio
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

add_subdirectory(${googletest_SOURCE_DIR} ${googletest_BINARY_DIR})

# Trivial example using gtest and gmock
add_executable(simple-generator-test)

target_sources(simple-generator-test
	PRIVATE
		"${CMAKE_CURRENT_SOURCE_DIR}/simple-generator-test.cpp"
)

target_link_libraries(simple-generator-test
	PRIVATE
		gtest
		gmock_main
		LLVMAnalysis
)

add_test(NAME simple-generator-test COMMAND simple-generator-test)

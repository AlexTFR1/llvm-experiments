## Build custom passes as a part of the LLVM build environment

There is no dynamic linking on Windows (this is OS weirdness) so we cannot use the plugins at all, unfortunately.

To build the pass, do the following:

 1. copy the `LLVMExperimentPasses` pass directory in the `lib/Transforms` one. Here and throughout, all paths are given at the
    root of the LLVM source directory.

 2. add the `add_subdirectory(LLVMExperimentPasses)` line into `lib/Transforms/CMakeLists.txt`

 3. for each implemented pass, add a function named `initialize${THE_NAME_OF_THE_PASS}Pass(PassRegistry &);` into the `include/llvm/InitializePasses.h`
    header file. Also add the funtion `void initializeLLVMExperimentPasses(PassRegistry &);` there. For example, for the `FunctionArgumentCount` pass
    add the following lines:

    ```cpp
    // my experiment passes
    void initializeLLVMExperimentPasses(PassRegistry &);
    void initializeFunctionArgumentCountPass(PassRegistry &);
    } // end namespace llvm

    ```

    (the functions **must be** defined inside the `llvm` namespace).

 4. add the `LLVMExperimentPasses` library to the `LLVM_LINK_COMPONENTS` list in the `tools/opt/CMakeLists.txt` file:

    ```cmake
    set(LLVM_LINK_COMPONENTS
        ${LLVM_TARGETS_TO_BUILD}
        AggressiveInstCombine
        ...
        ExperimentPasses
    )

    ```

    **Note:** The form of `ExperimentPasses`, not `LLVMExperimentPasses` is used here.

 5. register the passes into the `opt` tool by adding an invocation of the `initializeLLVMExperimentPasses` function to the `main` method
    of the tool (file `tools/opt/opt.cpp`):

    ```cpp
    // Initialize passes
    PassRegistry &Registry = *PassRegistry::getPassRegistry();
    initializeCore(Registry);
    ...
    initializeLLVMExperimentPasses(Registry);
    // For codegen passes, only passes that do IR to IR transformation are
    // supported.
    ```

 6. rebuild LLVM (`YOUR_LLVM_BUILDTREE` is the directory where you build LLVM) and install the new output files:

    ```bash
    cd YOUR_LLVM_BUILDTREE

    cmake -DCMAKE_CXX_COMPILER=YOUR_FAVOURITE_COMPILER -DCMAKE_C_COMPILER=YOUR_FAVOURITE_COMPILER -DCMAKE_LINKER=YOUR_FAVOURITE_LINKER .. -G"Ninja"

    cmake --build .

    cmake --build . --target install
    ```

  7. The passes are ready. For instance, the `FunctionArgumentCount` pass is registered as `fnargcnt` in the `opt` tool and can be invoked
     using the following command line:

     ```bash
     opt.exe -fnargcnt < sum.bc > sum-out.bc
     ```

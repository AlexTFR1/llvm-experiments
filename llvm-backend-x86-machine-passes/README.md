## Build custom machine passes as a part of the LLVM build environment

There is no dynamic linking on Windows (this is OS weirdness), so we cannot use the plugins at all, unfortunately.

To build the pass, do the following:

 1. copy all files from this directory except `README.md` and `patches` into the `lib/Target/X86` one. Here and throughout, all paths
    are given at the root of the LLVM source directory.

 2. add the names of the copied files just after `set(sources` line line into `lib/Target/X86/CMakeLists.txt`:

    ```cmake
    set(sources
      CountInstructionsPass.cpp
      ShadowCallStack.cpp
      ...
    ```

 3. for each implemented pass, add two functions named `initialize${THE_NAME_OF_THE_PASS}Pass(PassRegistry &);` and
    `create${THE_NAME_OF_THE_PASS}` into the `lib/Target/X86/X86.h` header file. The function
    `create${THE_NAME_OF_THE_PASS}` must be implemented in the corresponding pass.

    For example, add the following lines for the `CountInstructionsPass` pass:

    ```cpp
    // from llvm-backend-x86-machine-passes
    void initializeCountInstructionsPassPass(PassRegistry &);
    FunctionPass *createCountInstructionsPass();
    } // End llvm namespace
    ```

    (the functions **must be** declared inside the `llvm` namespace).

 4. register the passes into the `lib/Target/X86/X86TargetMachine.cpp` machine descriptor. Add an
    invocation of each `initialize${THE_NAME_OF_THE_PASS}Pass` function to the end of the
    `extern "C" void LLVMInitializeX86Target()` method definition.

    ```cpp
    extern "C" void LLVMInitializeX86Target() {
      // Register the target.
      RegisterTargetMachine<X86TargetMachine> X(getTheX86_32Target());
      RegisterTargetMachine<X86TargetMachine> Y(getTheX86_64Target());

      PassRegistry &PR = *PassRegistry::getPassRegistry();
      initializeGlobalISel(PR);
      ...
      // from llvm-backend-x86-machine-passes
      initializeCountInstructionsPassPass(PR);
    )
    ```

 5. add an invocation of the `addPass` function for each `create${THE_NAME_OF_THE_PASS}` method to the right location -
    an implementation of the appropriate method of the `X86PassConfig` (derived from `TargetPassConfig`) class.
    All implementations can be found inside the same machine descriptor - `lib/Target/X86/X86TargetMachine.cpp`.
    For example, add the `createCountInstructionsPass()` method invocation to the end of the `X86PassConfig::addPreEmitPass()`
    method:

    ```cpp
    void X86PassConfig::addPreEmitPass() {
      ...
      // from llvm-backend-x86-machine-passes
      addPass(createCountInstructionsPass());
    }
    ```

 P.S. Points 2 - 5 can be automated using the following command (it is applicable only if you are using an LLVM Git repo):

 ```bash
 git apply <PATH_TO_YOUR_LLVM_EXPERIMENTS_COPY>/llvm-backend-x86-machine-passes/patches/register-x86-machine-passes.patch
 ```

 The command must be executed from the **LLVM** Git repo, not **LLVM Experiments**.


 6. rebuild LLVM (`YOUR_LLVM_BUILDTREE` is the directory where you build LLVM) and install the new output files:

    ```bash
    cd YOUR_LLVM_BUILDTREE

    cmake -DCMAKE_CXX_COMPILER=YOUR_FAVOURITE_COMPILER -DCMAKE_C_COMPILER=YOUR_FAVOURITE_COMPILER -DCMAKE_LINKER=YOUR_FAVOURITE_LINKER .. -G"Ninja"

    cmake --build .

    cmake --build . --target install
    ```

  7. The passes are ready. For instance, `CountInstructionsPass` will be invoked
     using the following command line:

     ```bash
     llc.exe -march=x86-64 sum-o1.bc -debug-pass=Structure -debug-only=mcount --x86-asm-syntax=intel
     ```

     The output:

     ```
     <skipped>
     FunctionPass Manager
           <skipped>
           Machine Count Pass
           X86 Assembly Printer
           Free MachineFunction
     Function 'main' consists of the following instructions:
        'SEH_Epilogue': 1
        'SUB64ri8': 1
        'SEH_StackAlloc': 1
        'ADD64ri8': 1
        'MOVSDmr': 1
        'MOVSDrm': 2
        'CALL64pcrel32': 1
        'MOV32mi': 1
        'RETQ': 1
        'CVTTSD2SIrm': 1
        'SEH_EndPrologue': 1
     total: 12
     ```

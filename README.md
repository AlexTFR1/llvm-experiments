## Experiments with the LLVM compiler infrastructure

Yet another learning path to the heart of the LLVM compiler infrastructure.

 1. **[llvm-first-step](llvm-first-step)** - the simplest `llvm` demo:
    just reads a bitcode file and outs how many basic blocks are in every function.

 2. **[llvm-front-clang-demo](llvm-front-clang-demo)** - let's see how to deal with
   `clang-lib`: lexer, parser, diagnostics, traversing the AST, etc. The most
    interesting example is [declared-methods-c.cpp][declared-methods-c] that
    demonstrates how to distinguish declarations from definitions.

 3. **[llvm-ir-custom-passes](llvm-ir-custom-passes)** - a collection of analysis
    and optimization passes for the `opt` tool. You can start from the
    [FunctionArgumentUsagePass][function-argument-usage-pass] analysis pass that
    diagnoses type mismatches around function calls. The idea is borrowed from
    the task *[Writing your own Analysis Pass][writing-your-own-analysis-pass]*,
    course *CSCI565 Compilers Design*.
    
    P.S. There is an instruction how to build the passes as a part of the LLVM build
    tree and a patch for LLVM sources which can help you register the passes.

 4. **[llvm-backend-x86-machine-pass](llvm-backend-x86-machine-passes)** - a collection
    of machine passes for the `X86` backend. Passes demonstrate how to deal with
    the code generation, data-flow analysis, register allocation, MC layer and
    other cool back-end stuff.
    
    P.S. There is an instruction how to build the machine passes as a part of
    the LLVM build tree and a patch for LLVM sources which can help you register
    the passes.

 5. **[llvm-ir-tests](llvm-ir-tests)** - a bunch of source code (C/C++) and .bc
    files to test the compiler infrastructure.

 6. **[llvm-unit-tests](llvm-unit-tests)** - in the XXI century without unit tests?
    No way! There are all unit tests for the code in the repository. The directory
    matches to the `unittests` one from the LLVM source tree.

I wish to thank Bruno Cardoso Lopes and Rafael Auler, the authors of **[Getting
Started with LLVM Core Libraries][llvm-getting-started]**. Their book is the
best introduction in the LLVM infrastructure I met. Some examples from the book
were used as a kick-starters for the project.

### Building the project

You need *[CMake][cmake-site]* to build the experiments (those parts which don't
have to be built as parts of the LLVM source tree). The variable `LLVM_INSTALL_PREFIX`
must point to the parent directory of an LLVM installation.

**Note:** The build type of the experiments should correspond to the build type
of the LLVM installation taken in account otherwise a number of linker errors
will occur at least, if you are using the MSVC compiler.

```bash
# mkdir build
# cd build
# cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_INSTALL_PREFIX="<PATH_TO_YOUR_LLVM>" -G"Ninja" ..
# cmake --build .
```

Now the unit tests can be starting from the `build/llvm-unit-tests` dir:

```bash
# cd llvm-unit-tests
# ctest -V

...

100% tests passed, 0 tests failed out of ...
```

[writing-your-own-analysis-pass]: http://www.isi.edu/~pedro/Teaching/CSCI565-Spring15/Projects/Project1-LLVM/Project1-LLVM.pdf
[function-argument-usage-pass]: llvm-ir-custom-passes/LLVMExperimentPasses/FunctionArgumentUsagePass.cpp
[declared-methods-c]: llvm-front-clang-demo/declared-methods-c.cpp
[cmake-site]: https://cmake.org/
[llvm-getting-started]: https://www.amazon.com/Getting-Started-LLVM-Core-Libraries/dp/1782166920

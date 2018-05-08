add_llvm_library(LLVMExperimentPasses
  FunctionArgumentCount.cpp
  RegisterPasses.cpp

  DEPENDS
  intrinsics_gen
  )

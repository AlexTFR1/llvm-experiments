add_llvm_library(LLVMExperimentPasses
  FunctionArgumentCount.cpp
  FunctionArgumentUsagePass.cpp
  RegisterPasses.cpp

  DEPENDS
  intrinsics_gen
  )

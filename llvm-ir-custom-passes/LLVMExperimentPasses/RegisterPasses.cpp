#include "llvm/InitializePasses.h"
#include "llvm/PassRegistry.h"

using namespace llvm;

/// initializeLLVMExperimentPasses - Initialize all passes in the LLVMExperimentPasses
/// library.
void llvm::initializeLLVMExperimentPasses(PassRegistry &Registry) {
    initializeFunctionArgumentCountPass(Registry);
}

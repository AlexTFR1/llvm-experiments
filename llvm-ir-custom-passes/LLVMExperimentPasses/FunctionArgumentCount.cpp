#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
    class FunctionArgumentCount : public FunctionPass {
        public:
            static char ID;
            FunctionArgumentCount() : FunctionPass(ID) {}
            virtual void getAnalysisUsage(AnalysisUsage &AU) const {
                AU.setPreservesAll();
            }
            virtual bool runOnFunction(Function &F) {
                errs() << "FunctionArgumentCount --- ";
                errs() << F.getName() << ": ";
                errs() << F.arg_size() << '\n';
                return false;
            }
            virtual bool doFinalization(Module &M) {
                errs() << "doFinalization(Module &M) for " << M.getName() << '\n';
                return true;
            }
            virtual void print(llvm::raw_ostream &O, const Module *M) const {
                O << "FunctionArgumentCount informs:\n\tI'm an analyser" << '\n';
            }
            virtual void releaseMemory() {
                errs() << "release memory" << '\n';
            }
    };
}

char FunctionArgumentCount::ID = 0;

INITIALIZE_PASS(FunctionArgumentCount, "fnargcnt", "Function Argument Count Pass",
        false /* Only looks at CFG */,
        false /* Analysis Pass */);

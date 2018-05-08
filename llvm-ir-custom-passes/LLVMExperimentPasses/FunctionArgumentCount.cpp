#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
    class FunctionArgumentCount : public FunctionPass {
        public:
            static char ID;
            FunctionArgumentCount() : FunctionPass(ID) {}
            virtual bool runOnFunction(Function &F) {
                errs() << "FunctionArgumentCount --- ";
                errs() << F.getName() << ": ";
                errs() << F.arg_size() << '\n';
                return false;
            }
    };
}

char FunctionArgumentCount::ID = 0;

INITIALIZE_PASS(FunctionArgumentCount, "fnargcnt", "Function Argument Count Pass",
        false /* Only looks at CFG */,
        false /* Analysis Pass */);

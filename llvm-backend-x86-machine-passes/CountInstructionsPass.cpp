#define DEBUG_TYPE "mcount"

#include "X86.h"
#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
    class CountInstructionsPass : public MachineFunctionPass {
        public:
            static char ID;

            CountInstructionsPass() : MachineFunctionPass(ID) {}

            virtual bool runOnMachineFunction(MachineFunction &MF) override {
                unsigned num_instr = 0;
                for (auto I = MF.begin(), E = MF.end(); I != E; ++I) {
                    for (auto BBI = I->begin(); BBI != I->end(); ++BBI) {
                        ++num_instr;
                    }
                }

                errs() << "mcount: function '" << MF.getName() << "' has " << num_instr
                       << " instructions.\n";
                return false;
            }
    };
}

char CountInstructionsPass::ID = 0;

INITIALIZE_PASS(CountInstructionsPass, "mcount", "Machine Count Pass", false, false);

FunctionPass *llvm::createCountInstructionsPass() { return new CountInstructionsPass(); }

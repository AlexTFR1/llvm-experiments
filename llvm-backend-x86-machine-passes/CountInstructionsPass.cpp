#include "X86.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/TargetInstrInfo.h"
#include "llvm/CodeGen/TargetSubtargetInfo.h"
#include "llvm/Support/raw_ostream.h"

#define DEBUG_TYPE "mcount"

using namespace llvm;

static cl::opt<unsigned> AverageUniqueInstructions(
    "avg-unique-instrs", cl::Hidden,
    cl::desc("Average number of unique instructions in a function "
             "under analysis"),
    cl::init(16));

namespace {
    class CountInstructionsPass : public MachineFunctionPass {
        public:
            using UniqueInstructionMap = DenseMap<unsigned, unsigned>;

            static char ID;

            CountInstructionsPass() :
                MachineFunctionPass(ID),
                UniqueInstructionCounts(UniqueInstructionMap(AverageUniqueInstructions)),
                TTI(nullptr) { }

            virtual bool runOnMachineFunction(MachineFunction &MF) override {
                TTI = MF.getSubtarget().getInstrInfo();
                unsigned total = 0;
                for (auto BBI = MF.begin(), BBE = MF.end(); BBI != BBE; ++BBI) {
                    for (auto II = BBI->begin(), IE = BBI->end(); II != IE; ++II) {
                        addInstruction(II->getOpcode());
                        total++;
                    }
                }
                LLVM_DEBUG(printDebugInfo(MF.getName(), total));
                return false;
            }

            virtual void print(llvm::raw_ostream &O, const Module *M) const override {
                // There is no a way to invoke the print method for a machine pass.
            }

            virtual void releaseMemory() override {
                TTI = nullptr;
                UniqueInstructionCounts.clear();
            }
        private:
            UniqueInstructionMap UniqueInstructionCounts;
            const TargetInstrInfo * TTI;

            void addInstruction(unsigned opcode) {
                unsigned count = UniqueInstructionCounts.lookup(opcode);
                if (count) {
                    UniqueInstructionCounts[opcode] = ++count;
                } else {
                    UniqueInstructionCounts.try_emplace(opcode, 1);
                }
            }

            void printDebugInfo(const StringRef functionName, unsigned total) const {
                dbgs() << "Function '";
                dbgs().write_escaped(functionName);
                dbgs() << "' consists of the following instructions: \n";
                for (auto UFI = UniqueInstructionCounts.begin(),
                        UFE = UniqueInstructionCounts.end();
                        UFI != UFE; ++UFI) {
                    dbgs() << "\t'" << TTI->getName(UFI->getFirst())
                           << "': " << UFI->getSecond() << "\n";
                }
                dbgs() << "total: " << total << "\n";
            }
    };
}

char CountInstructionsPass::ID = 0;

INITIALIZE_PASS(CountInstructionsPass, "mcount", "Machine Count Pass", false, false);

FunctionPass *llvm::createCountInstructionsPass() { return new CountInstructionsPass(); }

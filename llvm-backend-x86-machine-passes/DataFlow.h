#ifndef DATAFLOW_H_
#define DATAFLOW_H_

#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/Support/raw_ostream.h"

class DataFlowVisitor {
    public:
        virtual operator()() {
            errs() << "DataFlowVisitor()" << "\n";
        }
        virtual ~DataFlowVisitor() {}
};

class DataFlowAnalysis {
    public:
        virtual void traverse(MachineFunction &MF, DataFlowVisitor &Visitor) = 0;
        virtual ~DataFlowAnalysis() {}
    private:
};

class BackwardDataFlowAnalysis : public DataFlowAnalysis {
    public:
        void traverse(MachineFunction &MF, DataFlowVisitor &Visitor);
};
#endif //DATAFLOW_H_
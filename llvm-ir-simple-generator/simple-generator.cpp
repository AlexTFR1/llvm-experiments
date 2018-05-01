#include <llvm/ADT/SmallVector.h>
#include <llvm/IR/Attributes.h>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/CallingConv.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Metadata.h>
#include <llvm/IR/IRPrintingPasses.h>
#include <llvm/IR/Verifier.h>
#include <llvm/Bitcode/BitcodeWriter.h>
#include <llvm/Support/CodeGen.h>
#include <llvm/Support/FileSystem.h>
#include <llvm/Support/ToolOutputFile.h>
#include <llvm/Support/raw_os_ostream.h>

using namespace llvm;

static LLVMContext TheContext;

void addLLVMIdentMetadata(Module *module) {
    MDString *Elts[] = {
        MDString::get(module->getContext(), "clang version 7.0.0")
    };
    MDNode *Node = MDNode::get(module->getContext(), ArrayRef<Metadata *>(Elts[0]));

    NamedMDNode *NMD = module->getOrInsertNamedMetadata("llvm.ident");
    NMD->addOperand(Node);
}

Module *makeLLVMModule() {
    Module *module = new Module("min.bc", TheContext);
    module->setDataLayout("e-m:w-i64:64-f80:128-n8:16:32:64-S128");
    module->setTargetTriple("x86_64-pc-windows-msvc19.13.26129");
    // experiment with module flags
    module->addModuleFlag(Module::ModFlagBehavior::Error, "wchar_size", 2);
    module->setPICLevel(PICLevel::Level::BigPIC);
    // experiment with module metadata (llvm.ident)
    addLLVMIdentMetadata(module);

    SmallVector<Type*, 2> funcTypeArgs;
    funcTypeArgs.push_back(IntegerType::get(module->getContext(), 32));
    funcTypeArgs.push_back(IntegerType::get(module->getContext(), 32));
    FunctionType *funcType = FunctionType::get(
        /* Result= */   IntegerType::get(module->getContext(), 32),
        /* Params= */   funcTypeArgs,
        /* isVarArg= */ false);

    Function *funcMin = Function::Create(
        /* Type= */    funcType,
        /* Linkage= */ GlobalValue::ExternalLinkage,
        /* Name= */    "min",
        /* Module= */   module);

    // set ABI and visibility
    funcMin->setCallingConv(CallingConv::C);
    funcMin->setDSOLocal(true);

    // define function attributes
    funcMin->addFnAttr(Attribute::AttrKind::NoInline);
    funcMin->addFnAttr(Attribute::AttrKind::NoUnwind);
    funcMin->addFnAttr(Attribute::AttrKind::UWTable);

    Function::arg_iterator args = funcMin->arg_begin();
    Value *int32_a = args++;
    int32_a->setName("a");

    Value *int32_b = args++;
    int32_b->setName("b");

    // Basic blocks are described here
    BasicBlock *labelEntry = BasicBlock::Create(module->getContext(),
         "entry", funcMin, 0);
    BasicBlock *ifthenEntry = BasicBlock::Create(module->getContext(),
        "if.then", funcMin, 0);
    BasicBlock *ifelseEntry = BasicBlock::Create(module->getContext(),
        "if.else", funcMin, 0);
    BasicBlock *returnEntry = BasicBlock::Create(module->getContext(),
        "return", funcMin, 0);

    // Block entry (label_entry)
    AllocaInst *retVal = new AllocaInst(IntegerType::get(module->getContext(), 32),
        0, "retval", labelEntry);
    retVal->setAlignment(4);
    AllocaInst *ptrA = new AllocaInst(IntegerType::get(module->getContext(), 32),
        0, "a.addr", labelEntry);
    ptrA->setAlignment(4);
    AllocaInst *ptrB = new AllocaInst(IntegerType::get(module->getContext(), 32),
        0, "b.addr", labelEntry);
    ptrB->setAlignment(4);
    StoreInst *st0 = new StoreInst(int32_a, ptrA, false, labelEntry);
    st0->setAlignment(4);
    StoreInst *st1 = new StoreInst(int32_b, ptrB, false, labelEntry);
    st1->setAlignment(4);
    LoadInst *ld0 = new LoadInst(ptrA, "", false, labelEntry);
    ld0->setAlignment(4);
    LoadInst *ld1 = new LoadInst(ptrB, "", false, labelEntry);
    ld1->setAlignment(4);
    CmpInst *cmpRes = ICmpInst::Create(Instruction::ICmp,
        ICmpInst::Predicate::ICMP_SLT, ld0, ld1, "cmp", labelEntry);
    BranchInst::Create(ifthenEntry, ifelseEntry, cmpRes, labelEntry);

    // Block entry (if.then)
    LoadInst *ld2 = new LoadInst(ptrA, "", false, ifthenEntry);
    ld2->setAlignment(4);
    StoreInst *st2 = new StoreInst(ld2, retVal, false, ifthenEntry);
    st2->setAlignment(4);
    BranchInst::Create(returnEntry, ifthenEntry);

    // Block entry (if.else)
    LoadInst *ld3 = new LoadInst(ptrB, "", false, ifelseEntry);
    ld3->setAlignment(4);
    StoreInst *st3 = new StoreInst(ld3, retVal, false, ifelseEntry);
    st3->setAlignment(4);
    BranchInst::Create(returnEntry, ifelseEntry);

    // Block entry (return)
    LoadInst *ld4 = new LoadInst(retVal, "", false, returnEntry);
    ld4->setAlignment(4);
    ReturnInst::Create(module->getContext(), ld4, returnEntry);

    return module;
}

int main() {
    auto module = makeLLVMModule();
    if (verifyModule(*module, &errs())) {
        return -1;
    }

    std::error_code ec;
    auto outputFile = new ToolOutputFile("./min.bc", ec, sys::fs::F_None);
    if (ec) {
        errs() << ec.message() << '\n';
        return -1;
    }
    WriteBitcodeToFile(*module, outputFile->os());
    outputFile->keep(); // Declare success
    outputFile->os().flush(); // Flush is must!
    return 0;
}

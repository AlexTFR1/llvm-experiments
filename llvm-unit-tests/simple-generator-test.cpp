#include "gtest/gtest.h"
#include "gmock/gmock.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"

using namespace llvm;

namespace {
    class SimpleIRGenerator {
        public:
            std::unique_ptr<Module> generate();
            virtual ~SimpleIRGenerator() {}
        private:
            virtual bool verify(const Module *module, raw_ostream *OS) const;
    };

    // Mock class
    class MockSimpleIRGenerator : public SimpleIRGenerator {
        public:
            MOCK_CONST_METHOD2(verify, bool(const Module *module, raw_ostream *OS));
    };

    static LLVMContext TheContext;
}

std::unique_ptr<Module> SimpleIRGenerator::generate() {
    Module *module = new Module("min.bc", TheContext);
    module->setDataLayout("e-m:w-i64:64-f80:128-n8:16:32:64-S128");
    module->setTargetTriple("x86_64-pc-windows-msvc19.13.26129");
    // experiment with module flags
    module->addModuleFlag(Module::ModFlagBehavior::Error, "wchar_size", 2);
    module->setPICLevel(PICLevel::Level::BigPIC);
    // experiment with module metadata (llvm.ident)
    MDString *Elts[] = {
        MDString::get(module->getContext(), "clang version 7.0.0")
    };
    MDNode *Node = MDNode::get(module->getContext(), ArrayRef<Metadata *>(Elts[0]));
    NamedMDNode *NMD = module->getOrInsertNamedMetadata("llvm.ident");
    NMD->addOperand(Node);
    assert(verify(module, &dbgs()) && "Module is not valid");
    return std::unique_ptr<Module>(module);
}

bool SimpleIRGenerator::verify(const Module *module, raw_ostream *OS) const {
    return verifyModule(*module, OS);
}

using ::testing::AtMost;
using ::testing::Return;
using ::testing::_;

TEST(SimpleGenerator, metadata) {
    MockSimpleIRGenerator mockGenerator;
    EXPECT_CALL(mockGenerator, verify(_, _))
        .Times(AtMost(1))
        .WillOnce(Return(true));

    std::unique_ptr<Module> module = std::move(mockGenerator.generate());
    ASSERT_EQ("e-m:w-i64:64-f80:128-n8:16:32:64-S128", module->getDataLayoutStr());
    ASSERT_EQ("x86_64-pc-windows-msvc19.13.26129", module->getTargetTriple());
    ASSERT_EQ(PICLevel::Level::BigPIC, module->getPICLevel());
}

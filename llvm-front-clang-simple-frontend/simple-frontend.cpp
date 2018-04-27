#include "llvm/Support/CommandLine.h"
#include "clang/AST/ASTContext.h"
#include "clang/Basic/DiagnosticOptions.h"
#include "clang/Basic/FileManager.h"
#include "clang/Basic/SourceManager.h"
#include "clang/Basic/TargetOptions.h"
#include "clang/Frontend/ASTConsumers.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/Lex/PreprocessorOptions.h"
#include "clang/Parse/ParseAST.h"
#include <iostream>

using namespace llvm;
using namespace clang;

static cl::opt<std::string>
FileName(cl::Positional, cl::desc("Input file"), cl::Required);

int main(int argc, char **argv) {
    cl::ParseCommandLineOptions(argc, argv, "My simple front end\n");

    CompilerInstance CI;
    DiagnosticOptions diagnosticOptions;
    CI.createDiagnostics();

    const std::shared_ptr<clang::TargetOptions> PTO(new clang::TargetOptions());
    PTO->Triple = sys::getDefaultTargetTriple();
    TargetInfo *PTI = TargetInfo::CreateTargetInfo(CI.getDiagnostics(), PTO);
    CI.setTarget(PTI);

    CI.createFileManager();
    CI.createSourceManager(CI.getFileManager());
    CI.createPreprocessor(TU_Complete);
    CI.getPreprocessorOpts().UsePredefines = false;

    auto astConsumer = CreateASTPrinter(NULL, "");
    CI.setASTConsumer(std::move(astConsumer));

    CI.createASTContext();
    CI.createSema(TU_Complete, NULL);
    const FileEntry *pFile = CI.getFileManager().getFile(FileName);
    if (!pFile) {
        std::cerr << "File not found: " << FileName << std::endl;
        return 1;
    }

    CI.getSourceManager().setMainFileID(CI.getSourceManager().createFileID(pFile,
        SourceLocation(), SrcMgr::C_User));
    CI.getDiagnosticClient().BeginSourceFile(CI.getLangOpts(), 0);
    ParseAST(CI.getSema());

    // Print AST Statistics
    CI.getASTContext().PrintStats();
    CI.getASTContext().Idents.PrintStats();

    return 0;
}

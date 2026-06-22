#include "JVMTargetMachine.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/Target/TargetLoweringObjectFile.h"
#include "llvm/CodeGen/TargetLoweringObjectFileImpl.h"
#include "TargetInfo/JVMTargetInfo.h"

using namespace llvm;

extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeJVMTarget() {
  RegisterTargetMachine<JVMTargetMachine> X(getTheJVMTarget());
}

JVMTargetMachine::JVMTargetMachine(const Target &T, const Triple &TT, StringRef CPU,
                                   StringRef FS, const TargetOptions &Options,
                                   std::optional<Reloc::Model> RM,
                                   std::optional<CodeModel::Model> CM, CodeGenOptLevel OL,
                                   bool JIT)
    : TargetMachine(T, "e-m:e-p:32:32-i64:64-n32:64-S128", TT, CPU, FS, Options),
      TLOF(std::make_unique<TargetLoweringObjectFileELF>()),
      Subtarget(TT, CPU, FS, *this) {}

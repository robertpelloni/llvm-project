#ifndef LLVM_LIB_TARGET_JVM_JVMTARGETMACHINE_H
#define LLVM_LIB_TARGET_JVM_JVMTARGETMACHINE_H

#include "llvm/Target/TargetMachine.h"
#include "llvm/CodeGen/TargetSubtargetInfo.h"
#include "llvm/Target/TargetOptions.h"

namespace llvm {

class JVMSubtarget : public TargetSubtargetInfo {
public:
  JVMSubtarget(const Triple &TT, StringRef CPU, StringRef FS, const TargetMachine &TM)
    : TargetSubtargetInfo(TT, CPU, CPU, FS, ArrayRef<StringRef>(), ArrayRef<SubtargetFeatureKV>(), ArrayRef<SubtargetSubTypeKV>(), nullptr, nullptr, nullptr, nullptr, nullptr, nullptr) {}

  const TargetRegisterInfo *getRegisterInfo() const override { return nullptr; }
  const TargetInstrInfo *getInstrInfo() const override { return nullptr; }
  const TargetFrameLowering *getFrameLowering() const override { return nullptr; }
  const TargetLowering *getTargetLowering() const override { return nullptr; }
  const SelectionDAGTargetInfo *getSelectionDAGInfo() const override { return nullptr; }
};

class JVMTargetMachine : public TargetMachine {
  std::unique_ptr<TargetLoweringObjectFile> TLOF;
  JVMSubtarget Subtarget;
public:
  TargetLoweringObjectFile *getObjFileLowering() const override { return TLOF.get(); }
  JVMTargetMachine(const Target &T, const Triple &TT, StringRef CPU,
                   StringRef FS, const TargetOptions &Options,
                   std::optional<Reloc::Model> RM,
                   std::optional<CodeModel::Model> CM, CodeGenOptLevel OL,
                   bool JIT);

    const TargetSubtargetInfo *getSubtargetImpl(const Function &F) const override { return &Subtarget; }
};

} // end namespace llvm

#endif

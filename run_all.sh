#!/bin/bash
set -ex

sed -i 's/    ve,             \/\/ NEC SX-Aurora Vector Engine/    ve,             \/\/ NEC SX-Aurora Vector Engine\n    jvm,            \/\/ JVM: Java Virtual Machine/' llvm/include/llvm/TargetParser/Triple.h
sed -i 's/    LastArchType = ve/    LastArchType = jvm/' llvm/include/llvm/TargetParser/Triple.h

sed -i 's/  case ve:\n    return "ve";/  case ve:\n    return "ve";\n  case jvm:\n    return "jvm";/' llvm/lib/TargetParser/Triple.cpp
sed -i 's/  case shave:\n    return "shave";/  case shave:\n    return "shave";\n  case jvm:\n    return "jvm";/' llvm/lib/TargetParser/Triple.cpp
sed -i 's/      .Case("shave", shave)/      .Case("shave", shave)\n      .Case("jvm", jvm)/' llvm/lib/TargetParser/Triple.cpp
sed -i 's/          .Case("ve", Triple::ve)/          .Case("ve", Triple::ve)\n          .Case("jvm", Triple::jvm)/' llvm/lib/TargetParser/Triple.cpp

sed -i 's/  case Triple::wasm32:\n  case Triple::wasm64:\n    return Triple::Wasm;/  case Triple::jvm:\n    return Triple::UnknownObjectFormat;\n\n  case Triple::wasm32:\n  case Triple::wasm64:\n    return Triple::Wasm;/' llvm/lib/TargetParser/Triple.cpp

sed -i 's/  case llvm::Triple::thumb:\n  case llvm::Triple::thumbeb:\n  case llvm::Triple::wasm32:/  case llvm::Triple::thumb:\n  case llvm::Triple::thumbeb:\n  case llvm::Triple::jvm:\n  case llvm::Triple::wasm32:/' llvm/lib/TargetParser/Triple.cpp

sed -i 's/  case Triple::thumb:\n  case Triple::thumbeb:\n  case Triple::wasm32:/  case Triple::thumb:\n  case Triple::thumbeb:\n  case Triple::jvm:\n  case Triple::wasm32:/' llvm/lib/TargetParser/Triple.cpp

sed -i 's/  case Triple::spirv32:\n  case Triple::spirv64:\n  case Triple::tcele64:\n  case Triple::wasm32:/  case Triple::spirv32:\n  case Triple::spirv64:\n  case Triple::tcele64:\n  case Triple::jvm:\n  case Triple::wasm32:/' llvm/lib/TargetParser/Triple.cpp

sed -i 's/  case Triple::tcele64:\n  case Triple::thumb:\n  case Triple::ve:\n  case Triple::wasm32:/  case Triple::tcele64:\n  case Triple::thumb:\n  case Triple::ve:\n  case Triple::jvm:\n  case Triple::wasm32:/' llvm/lib/TargetParser/Triple.cpp

sed -i 's/set(LLVM_ALL_EXPERIMENTAL_TARGETS\n  ARC\n  CSKY\n  DirectX\n/set(LLVM_ALL_EXPERIMENTAL_TARGETS\n  ARC\n  CSKY\n  DirectX\n  JVM\n/' llvm/CMakeLists.txt
sed -i 's/add_subdirectory(XCore)/add_subdirectory(XCore)\nadd_subdirectory(JVM)/' llvm/lib/Target/CMakeLists.txt

mkdir -p llvm/lib/Target/JVM

cat << 'INNER' > llvm/lib/Target/JVM/JVMTargetMachine.h
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
};

class JVMTargetMachine : public LLVMTargetMachine {
  std::unique_ptr<TargetLoweringObjectFile> TLOF;
  JVMSubtarget Subtarget;
public:
  JVMTargetMachine(const Target &T, const Triple &TT, StringRef CPU,
                   StringRef FS, const TargetOptions &Options,
                   std::optional<Reloc::Model> RM,
                   std::optional<CodeModel::Model> CM, CodeGenOptLevel OL,
                   bool JIT);

  TargetLoweringObjectFile *getObjFileLowering() const override { return TLOF.get(); }
  const TargetSubtargetInfo *getSubtargetImpl(const Function &F) const override { return &Subtarget; }
};

} // end namespace llvm

#endif
INNER

cat << 'INNER' > llvm/lib/Target/JVM/JVMTargetMachine.cpp
#include "JVMTargetMachine.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/Target/TargetLoweringObjectFile.h"
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
    : LLVMTargetMachine(T, "e-m:e-p:32:32-i64:64-n32:64-S128", TT, CPU, FS, Options, RM.value_or(Reloc::Static), CM.value_or(CodeModel::Small), OL),
      TLOF(std::make_unique<TargetLoweringObjectFile>()),
      Subtarget(TT, CPU, FS, *this) {}
INNER

cat << 'INNER' > llvm/lib/Target/JVM/JVMISelLowering.h
#ifndef LLVM_LIB_TARGET_JVM_JVMISELLOWERING_H
#define LLVM_LIB_TARGET_JVM_JVMISELLOWERING_H

#include "llvm/CodeGen/TargetLowering.h"

namespace llvm {
class JVMTargetMachine;

class JVMTargetLowering : public TargetLowering {
public:
  explicit JVMTargetLowering(const TargetMachine &TM, const TargetSubtargetInfo &STI);
};

} // end namespace llvm

#endif
INNER

cat << 'INNER' > llvm/lib/Target/JVM/JVMISelLowering.cpp
#include "JVMISelLowering.h"
#include "JVMTargetMachine.h"

using namespace llvm;

JVMTargetLowering::JVMTargetLowering(const TargetMachine &TM, const TargetSubtargetInfo &STI)
    : TargetLowering(TM, STI) {
  // Add mapping for standard LLVM IR selection DAG nodes conceptually
  setOperationAction(ISD::ADD, MVT::i32, Legal); // Conceptually maps to iadd
  setOperationAction(ISD::SUB, MVT::i32, Legal); // Conceptually maps to isub
  setOperationAction(ISD::LOAD, MVT::i32, Legal); // Conceptually maps to aload
  setOperationAction(ISD::STORE, MVT::i32, Legal); // Conceptually maps to astore
}
INNER

cat << 'INNER' > llvm/lib/Target/JVM/JVMInstructionSelector.cpp
#include "llvm/CodeGen/GlobalISel/InstructionSelector.h"
#include "JVMTargetMachine.h"

using namespace llvm;

namespace {
class JVMInstructionSelector : public InstructionSelector {
public:
  JVMInstructionSelector() : InstructionSelector() {}

  bool select(MachineInstr &I) override {
    return false;
  }
};
} // end anonymous namespace
INNER

cat << 'INNER' > llvm/lib/Target/JVM/CMakeLists.txt
add_llvm_component_group(JVM)
add_llvm_component_library(LLVMJVMCodeGen
  JVMISelLowering.cpp
  JVMInstructionSelector.cpp
  JVMTargetMachine.cpp

  LINK_COMPONENTS
  CodeGen
  Core
  MC
  Support
  Target
  JVMInfo

  ADD_TO_COMPONENT
  JVM
  )
add_subdirectory(TargetInfo)
INNER

mkdir -p llvm/lib/Target/JVM/TargetInfo

cat << 'INNER' > llvm/lib/Target/JVM/TargetInfo/CMakeLists.txt
add_llvm_component_library(LLVMJVMInfo
  JVMTargetInfo.cpp

  LINK_COMPONENTS
  MC
  Support

  ADD_TO_COMPONENT
  JVM
  )
INNER

cat << 'INNER' > llvm/lib/Target/JVM/TargetInfo/JVMTargetInfo.cpp
#include "TargetInfo/JVMTargetInfo.h"
#include "llvm/MC/TargetRegistry.h"
using namespace llvm;
Target &llvm::getTheJVMTarget() {
  static Target TheJVMTarget;
  return TheJVMTarget;
}
extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeJVMTargetInfo() {
  RegisterTarget<Triple::jvm> X(getTheJVMTarget(), "jvm", "JVM", "JVM");
}
INNER

cat << 'INNER' > llvm/lib/Target/JVM/TargetInfo/JVMTargetInfo.h
#ifndef LLVM_LIB_TARGET_JVM_TARGETINFO_JVMTARGETINFO_H
#define LLVM_LIB_TARGET_JVM_TARGETINFO_JVMTARGETINFO_H
namespace llvm {
class Target;
Target &getTheJVMTarget();
}
#endif
INNER

sed -i 's/#include "Targets\/TCE.h"/#include "Targets\/TCE.h"\n#include "Targets\/JVM.h"/' clang/lib/Basic/Targets.cpp
sed -i 's/  case llvm::Triple::wasm32:/  case llvm::Triple::jvm:\n    return std::make_unique<JVMTargetInfo>(Triple, Opts);\n  case llvm::Triple::wasm32:/' clang/lib/Basic/Targets.cpp

cat << 'INNER' > clang/lib/Basic/Targets/JVM.h
#ifndef LLVM_CLANG_LIB_BASIC_TARGETS_JVM_H
#define LLVM_CLANG_LIB_BASIC_TARGETS_JVM_H

#include "clang/Basic/TargetInfo.h"
#include "clang/Basic/TargetOptions.h"
#include "llvm/TargetParser/Triple.h"
#include "llvm/Support/Compiler.h"

namespace clang {
namespace targets {

class LLVM_LIBRARY_VISIBILITY JVMTargetInfo : public TargetInfo {
public:
  JVMTargetInfo(const llvm::Triple &Triple, const TargetOptions &)
      : TargetInfo(Triple) {
    resetDataLayout("e-p:32:32-i64:64-n32:64-S128");
  }

  void getTargetDefines(const LangOptions &Opts,
                        MacroBuilder &Builder) const override {
    Builder.defineMacro("__jvm__");
  }

  llvm::SmallVector<Builtin::InfosShard> getTargetBuiltins() const override {
    return {};
  }

  BuiltinVaListKind getBuiltinVaListKind() const override {
    return TargetInfo::VoidPtrBuiltinVaList;
  }

  std::string_view getClobbers() const override {
    return "";
  }

  ArrayRef<const char *> getGCCRegNames() const override {
    return {};
  }

  ArrayRef<TargetInfo::GCCRegAlias> getGCCRegAliases() const override {
    return {};
  }

  bool validateAsmConstraint(const char *&Name,
                             TargetInfo::ConstraintInfo &Info) const override {
    return false;
  }
};

} // namespace targets
} // namespace clang

#endif
INNER

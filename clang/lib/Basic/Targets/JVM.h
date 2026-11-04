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

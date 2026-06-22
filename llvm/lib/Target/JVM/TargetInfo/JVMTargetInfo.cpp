#include "JVMTargetInfo.h"
#include "llvm/MC/TargetRegistry.h"
using namespace llvm;
Target &llvm::getTheJVMTarget() {
  static Target TheJVMTarget;
  return TheJVMTarget;
}
extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeJVMTargetInfo() {
  RegisterTarget<Triple::jvm> X(getTheJVMTarget(), "jvm", "JVM", "JVM");
}

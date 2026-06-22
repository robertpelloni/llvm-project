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

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

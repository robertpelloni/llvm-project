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

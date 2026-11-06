//===-- JVM.td - Describe the JVM Target Machine -----------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Target description for the Java Virtual Machine (JVM) backend.
//
//===----------------------------------------------------------------------===//

include "llvm/Target/Target.td"

//===----------------------------------------------------------------------===//
// Subtarget Features and Target Properties
//===----------------------------------------------------------------------===//

include "JVMTargetProperties.td"

//===----------------------------------------------------------------------===//
// Instruction Set Masks & Categories
//===----------------------------------------------------------------------===//

include "JVMInstructionSetMask.td"

//===----------------------------------------------------------------------===//
// Bytecode Binary Formats & Attributes
//===----------------------------------------------------------------------===//

include "JVMBytecodeFormats.td"

//===----------------------------------------------------------------------===//
// Register and Instruction Set
//===----------------------------------------------------------------------===//

include "JVMRegisterInfo.td"
include "JVMInstrInfo.td"

def JVMInstrInfo : InstrInfo;

//===----------------------------------------------------------------------===//
// Processors supported
//===----------------------------------------------------------------------===//

def : ProcessorModel<"generic", NoSchedModel, []>;
def : ProcessorModel<"jvm21", NoSchedModel, [FeatureJava21, FeaturePanama]>;

//===----------------------------------------------------------------------===//
// Target Declaration
//===----------------------------------------------------------------------===//

def JVM : Target {
  let InstructionSet = JVMInstrInfo;
}

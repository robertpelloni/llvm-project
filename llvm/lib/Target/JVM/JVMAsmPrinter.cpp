//===-- JVMAsmPrinter.cpp - JVM Bytecode/Jasmin Assembly Writer -*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains the assembly printer for the JVM target backend,
// outputting human-readable JVM bytecode/Jasmin assembly instructions.
//
//===----------------------------------------------------------------------===//

#include "TargetInfo/JVMTargetInfo.h"
#include "llvm/CodeGen/AsmPrinter.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

#define DEBUG_TYPE "jvm-asm-printer"

namespace {

class JVMAsmPrinter : public AsmPrinter {
public:
  explicit JVMAsmPrinter(TargetMachine &TM,
                         std::unique_ptr<MCStreamer> Streamer)
      : AsmPrinter(TM, std::move(Streamer)) {}

  StringRef getPassName() const override { return "JVM Assembly Printer"; }

  void emitInstruction(const MachineInstr *MI) override {
    // Print the instruction using default asm printer mechanisms or Jasmin format
    SmallString<128> Str;
    raw_svector_ostream OS(Str);
    MI->print(OS);
    OutStreamer->emitRawText(Str);
  }

  bool runOnMachineFunction(MachineFunction &MF) override {
    SetupMachineFunction(MF);
    emitFunctionHeader();
    emitFunctionBody();
    return false;
  }
};

} // end anonymous namespace

extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeJVMAsmPrinter() {
  RegisterAsmPrinter<JVMAsmPrinter> X(getTheJVMTarget());
}

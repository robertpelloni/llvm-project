//===-- JVMInstrInfo.td - JVM Instruction Information -------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes the JVM bytecode instructions in TableGen format.
//
//===----------------------------------------------------------------------===//

// Instruction format base
class JVMInst<dag outs, dag ins, string asmstr, list<dag> pattern>
    : Instruction {
  field bits<8> Opcode = 0;
  let Namespace = "JVM";
  let DecoderNamespace = "JVM";

  dag OutOperandList = outs;
  dag InOperandList = ins;
  let AsmString = asmstr;
  let Pattern = pattern;
}

//===----------------------------------------------------------------------===//
// Instructions: Arithmetic (32-bit int)
//===----------------------------------------------------------------------===//

def IADD : JVMInst<(outs I32Regs:$dst), (ins I32Regs:$src1, I32Regs:$src2),
                   "iadd $src1, $src2",
                   [(set I32Regs:$dst, (add I32Regs:$src1, I32Regs:$src2))]> {
  let Opcode = 0x60;
}

def ISUB : JVMInst<(outs I32Regs:$dst), (ins I32Regs:$src1, I32Regs:$src2),
                   "isub $src1, $src2",
                   [(set I32Regs:$dst, (sub I32Regs:$src1, I32Regs:$src2))]> {
  let Opcode = 0x64;
}

def IMUL : JVMInst<(outs I32Regs:$dst), (ins I32Regs:$src1, I32Regs:$src2),
                   "imul $src1, $src2",
                   [(set I32Regs:$dst, (mul I32Regs:$src1, I32Regs:$src2))]> {
  let Opcode = 0x68;
}

def IDIV : JVMInst<(outs I32Regs:$dst), (ins I32Regs:$src1, I32Regs:$src2),
                   "idiv $src1, $src2",
                   [(set I32Regs:$dst, (sdiv I32Regs:$src1, I32Regs:$src2))]> {
  let Opcode = 0x6C;
}

//===----------------------------------------------------------------------===//
// Instructions: Control Flow
//===----------------------------------------------------------------------===//

let isReturn = 1, isTerminator = 1, isBarrier = 1 in {
  def IRETURN : JVMInst<(outs), (ins I32Regs:$val), "ireturn $val", []> {
    let Opcode = 0xAC;
  }

  def RETURN : JVMInst<(outs), (ins), "return", []> {
    let Opcode = 0xB1;
  }
}

//===----------------------------------------------------------------------===//
// Operands
//===----------------------------------------------------------------------===//

def brtarget : Operand<OtherVT>;

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
// Instructions: Arithmetic (64-bit long)
//===----------------------------------------------------------------------===//

def LADD : JVMInst<(outs I64Regs:$dst), (ins I64Regs:$src1, I64Regs:$src2),
                   "ladd $src1, $src2",
                   [(set I64Regs:$dst, (add I64Regs:$src1, I64Regs:$src2))]> {
  let Opcode = 0x61;
}

def LSUB : JVMInst<(outs I64Regs:$dst), (ins I64Regs:$src1, I64Regs:$src2),
                   "lsub $src1, $src2",
                   [(set I64Regs:$dst, (sub I64Regs:$src1, I64Regs:$src2))]> {
  let Opcode = 0x65;
}

def LMUL : JVMInst<(outs I64Regs:$dst), (ins I64Regs:$src1, I64Regs:$src2),
                   "lmul $src1, $src2",
                   [(set I64Regs:$dst, (mul I64Regs:$src1, I64Regs:$src2))]> {
  let Opcode = 0x69;
}

def LDIV : JVMInst<(outs I64Regs:$dst), (ins I64Regs:$src1, I64Regs:$src2),
                   "ldiv $src1, $src2",
                   [(set I64Regs:$dst, (sdiv I64Regs:$src1, I64Regs:$src2))]> {
  let Opcode = 0x6D;
}

//===----------------------------------------------------------------------===//
// Instructions: Floating Point (32-bit float and 64-bit double)
//===----------------------------------------------------------------------===//

def FADD : JVMInst<(outs F32Regs:$dst), (ins F32Regs:$src1, F32Regs:$src2),
                   "fadd $src1, $src2",
                   [(set F32Regs:$dst, (fadd F32Regs:$src1, F32Regs:$src2))]> {
  let Opcode = 0x62;
}

def FSUB : JVMInst<(outs F32Regs:$dst), (ins F32Regs:$src1, F32Regs:$src2),
                   "fsub $src1, $src2",
                   [(set F32Regs:$dst, (fsub F32Regs:$src1, F32Regs:$src2))]> {
  let Opcode = 0x66;
}

def FMUL : JVMInst<(outs F32Regs:$dst), (ins F32Regs:$src1, F32Regs:$src2),
                   "fmul $src1, $src2",
                   [(set F32Regs:$dst, (fmul F32Regs:$src1, F32Regs:$src2))]> {
  let Opcode = 0x6A;
}

def FDIV : JVMInst<(outs F32Regs:$dst), (ins F32Regs:$src1, F32Regs:$src2),
                   "fdiv $src1, $src2",
                   [(set F32Regs:$dst, (fdiv F32Regs:$src1, F32Regs:$src2))]> {
  let Opcode = 0x6E;
}

def DADD : JVMInst<(outs F64Regs:$dst), (ins F64Regs:$src1, F64Regs:$src2),
                   "dadd $src1, $src2",
                   [(set F64Regs:$dst, (fadd F64Regs:$src1, F64Regs:$src2))]> {
  let Opcode = 0x63;
}

def DSUB : JVMInst<(outs F64Regs:$dst), (ins F64Regs:$src1, F64Regs:$src2),
                   "dsub $src1, $src2",
                   [(set F64Regs:$dst, (fsub F64Regs:$src1, F64Regs:$src2))]> {
  let Opcode = 0x67;
}

def DMUL : JVMInst<(outs F64Regs:$dst), (ins F64Regs:$src1, F64Regs:$src2),
                   "dmul $src1, $src2",
                   [(set F64Regs:$dst, (fmul F64Regs:$src1, F64Regs:$src2))]> {
  let Opcode = 0x6B;
}

def DDIV : JVMInst<(outs F64Regs:$dst), (ins F64Regs:$src1, F64Regs:$src2),
                   "ddiv $src1, $src2",
                   [(set F64Regs:$dst, (fdiv F64Regs:$src1, F64Regs:$src2))]> {
  let Opcode = 0x6F;
}

//===----------------------------------------------------------------------===//
// Instructions: Bitwise and Shift Operations
//===----------------------------------------------------------------------===//

def IAND : JVMInst<(outs I32Regs:$dst), (ins I32Regs:$src1, I32Regs:$src2),
                   "iand $src1, $src2",
                   [(set I32Regs:$dst, (and I32Regs:$src1, I32Regs:$src2))]> {
  let Opcode = 0x7E;
}

def IOR : JVMInst<(outs I32Regs:$dst), (ins I32Regs:$src1, I32Regs:$src2),
                  "ior $src1, $src2",
                  [(set I32Regs:$dst, (or I32Regs:$src1, I32Regs:$src2))]> {
  let Opcode = 0x80;
}

def IXOR : JVMInst<(outs I32Regs:$dst), (ins I32Regs:$src1, I32Regs:$src2),
                   "ixor $src1, $src2",
                   [(set I32Regs:$dst, (xor I32Regs:$src1, I32Regs:$src2))]> {
  let Opcode = 0x82;
}

def ISHL : JVMInst<(outs I32Regs:$dst), (ins I32Regs:$src1, I32Regs:$src2),
                   "ishl $src1, $src2",
                   [(set I32Regs:$dst, (shl I32Regs:$src1, I32Regs:$src2))]> {
  let Opcode = 0x78;
}

def ISHR : JVMInst<(outs I32Regs:$dst), (ins I32Regs:$src1, I32Regs:$src2),
                   "ishr $src1, $src2",
                   [(set I32Regs:$dst, (sra I32Regs:$src1, I32Regs:$src2))]> {
  let Opcode = 0x7A;
}

def IUSHR : JVMInst<(outs I32Regs:$dst), (ins I32Regs:$src1, I32Regs:$src2),
                    "iushr $src1, $src2",
                    [(set I32Regs:$dst, (srl I32Regs:$src1, I32Regs:$src2))]> {
  let Opcode = 0x7C;
}

//===----------------------------------------------------------------------===//
// Instructions: Conversions
//===----------------------------------------------------------------------===//

def I2L : JVMInst<(outs I64Regs:$dst), (ins I32Regs:$src),
                  "i2l $src",
                  [(set I64Regs:$dst, (sext I32Regs:$src))]> {
  let Opcode = 0x85;
}

def L2I : JVMInst<(outs I32Regs:$dst), (ins I64Regs:$src),
                  "l2i $src",
                  [(set I32Regs:$dst, (trunc I64Regs:$src))]> {
  let Opcode = 0x88;
}

//===----------------------------------------------------------------------===//
// Instructions: Invocations
//===----------------------------------------------------------------------===//

def INVOKESTATIC : JVMInst<(outs), (ins i32imm:$method_idx),
                           "invokestatic $method_idx", []> {
  let Opcode = 0xB8;
}

def INVOKEVIRTUAL : JVMInst<(outs), (ins i32imm:$method_idx),
                            "invokevirtual $method_idx", []> {
  let Opcode = 0xB6;
}

//===----------------------------------------------------------------------===//
// Instructions: Control Flow
//===----------------------------------------------------------------------===//

let isReturn = 1, isTerminator = 1, isBarrier = 1 in {
  def IRETURN : JVMInst<(outs), (ins I32Regs:$val), "ireturn $val", []> {
    let Opcode = 0xAC;
  }

  def LRETURN : JVMInst<(outs), (ins I64Regs:$val), "lreturn $val", []> {
    let Opcode = 0xAD;
  }

  def RETURN : JVMInst<(outs), (ins), "return", []> {
    let Opcode = 0xB1;
  }
}

//===----------------------------------------------------------------------===//
// Instructions: Local Variable Loads and Stores
//===----------------------------------------------------------------------===//

def ILOAD : JVMInst<(outs I32Regs:$dst), (ins i32imm:$idx),
                    "iload $idx", []> {
  let Opcode = 0x15;
}

def ISTORE : JVMInst<(outs), (ins I32Regs:$val, i32imm:$idx),
                     "istore $idx", []> {
  let Opcode = 0x36;
}

def LLOAD : JVMInst<(outs I64Regs:$dst), (ins i32imm:$idx),
                    "lload $idx", []> {
  let Opcode = 0x16;
}

def LSTORE : JVMInst<(outs), (ins I64Regs:$val, i32imm:$idx),
                     "lstore $idx", []> {
  let Opcode = 0x37;
}

def ALOAD : JVMInst<(outs I32Regs:$dst), (ins i32imm:$idx),
                    "aload $idx", []> {
  let Opcode = 0x19;
}

def ASTORE : JVMInst<(outs), (ins I32Regs:$val, i32imm:$idx),
                     "astore $idx", []> {
  let Opcode = 0x3A;
}

//===----------------------------------------------------------------------===//
// Instructions: Branching and Comparisons
//===----------------------------------------------------------------------===//

let isBranch = 1, isTerminator = 1 in {
  def IFEQ : JVMInst<(outs), (ins I32Regs:$cond, brtarget:$target),
                     "ifeq $target", []> {
    let Opcode = 0x99;
  }

  def IFNE : JVMInst<(outs), (ins I32Regs:$cond, brtarget:$target),
                     "ifne $target", []> {
    let Opcode = 0x9A;
  }

  def GOTO : JVMInst<(outs), (ins brtarget:$target),
                     "goto $target", []> {
    let Opcode = 0xA7;
    let isBarrier = 1;
  }
}

//===-- JVMInstructionSetMask.td - JVM Opcode & Mask Defs -*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Classification and mask representations for JVM bytecodes.
//
//===----------------------------------------------------------------------===//

class JVMInstCategory<bits<4> val> {
  bits<4> Value = val;
}

def CatConstant    : JVMInstCategory<0x1>;
def CatLoadStore   : JVMInstCategory<0x2>;
def CatArithmetic  : JVMInstCategory<0x3>;
def CatControlFlow : JVMInstCategory<0x4>;
def CatInvocation  : JVMInstCategory<0x5>;
def CatMemory      : JVMInstCategory<0x6>;

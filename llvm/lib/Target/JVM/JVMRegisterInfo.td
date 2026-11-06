//===-- JVMRegisterInfo.td - JVM Register defs -------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//  Declarations that describe the JVM virtual register file.
//
//===----------------------------------------------------------------------===//

let Namespace = "JVM" in {
  class JVMReg<string n> : Register<n> {
    let Namespace = "JVM";
  }

  // 32-bit integer stack / local variable registers
  def R0 : JVMReg<"r0">;
  def R1 : JVMReg<"r1">;
  def R2 : JVMReg<"r2">;
  def R3 : JVMReg<"r3">;

  // 64-bit long stack / local variable registers
  def L0 : JVMReg<"l0">;
  def L1 : JVMReg<"l1">;

  // Float and Double registers
  def F0 : JVMReg<"f0">;
  def D0 : JVMReg<"d0">;
}

def I32Regs : RegisterClass<"JVM", [i32], 32, (add R0, R1, R2, R3)>;
def I64Regs : RegisterClass<"JVM", [i64], 64, (add L0, L1)>;
def F32Regs : RegisterClass<"JVM", [f32], 32, (add F0)>;
def F64Regs : RegisterClass<"JVM", [f64], 64, (add D0)>;

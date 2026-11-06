//===-- JVMBytecodeFormats.td - JVM Bytecode Binary Formats -*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// TableGen definitions describing JVM Classfile structures and attributes.
//
//===----------------------------------------------------------------------===//

class JVMClassAttribute<string name, bits<16> attrType> {
  string Name = name;
  bits<16> AttributeType = attrType;
}

def AttrCode           : JVMClassAttribute<"Code", 0x0001>;
def AttrConstantValue  : JVMClassAttribute<"ConstantValue", 0x0002>;
def AttrStackMapTable  : JVMClassAttribute<"StackMapTable", 0x0003>;
def AttrLineNumberTable: JVMClassAttribute<"LineNumberTable", 0x0004>;
def AttrSourceFile     : JVMClassAttribute<"SourceFile", 0x0005>;

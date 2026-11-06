//===-- JVMTargetProperties.td - JVM Target Properties ----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Subtarget feature and property definitions for the JVM target.
//
//===----------------------------------------------------------------------===//

def FeatureJava21 : SubtargetFeature<"java21", "HasJava21", "true",
                                     "Enable Java 21+ features">;

def FeaturePanama : SubtargetFeature<"panama", "HasPanama", "true",
                                     "Enable Project Panama Foreign Memory API">;

def FeatureUnsafe : SubtargetFeature<"unsafe", "HasUnsafe", "true",
                                     "Enable sun.misc.Unsafe memory operations">;

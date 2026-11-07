# LLVM JVM Target Backend: Immediate Tasks & Fixes

## Immediate Tasks
- [x] Add TableGen target description files (`JVM.td`, `JVMRegisterInfo.td`, `JVMInstrInfo.td`, `JVMTargetProperties.td`, `JVMInstructionSetMask.td`, `JVMBytecodeFormats.td`).
- [x] Expand TableGen instruction set to cover 64-bit integer, float/double, bitwise ops, conversions, and invocations.
- [x] Implement `JVMAsmPrinter` to support JVM assembly text dumping (Jasmin or Krakatau compatible format) for debugging.
- [ ] Implement `JVMTargetLowering::LowerFormalArguments` and `JVMTargetLowering::LowerReturn` for basic integer returns.
- [ ] Add unittests in `llvm/unittests/Target/JVM` or lit tests in `llvm/test/CodeGen/JVM/` checking basic arithmetic emission.
- [ ] Hook into Clang driver arguments to allow `-target jvm -c input.c -o output.class`.
- [ ] Test linking with `jvm-cpp-runtime` jar dependencies.

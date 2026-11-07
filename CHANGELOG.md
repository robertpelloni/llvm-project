# Changelog

All notable changes to this project are documented in this file.
The version format corresponds to `VERSION.md`.

## [0.1.0-alpha.4] - 2026-06-22

### Added
- Expanded TableGen instruction definitions in `llvm/lib/Target/JVM/JVMInstrInfo.td`:
  - 64-bit integer arithmetic: `LADD`, `LSUB`, `LMUL`, `LDIV`, `LLOAD`, `LSTORE`, `LRETURN`.
  - Floating point arithmetic: `FADD`, `FSUB`, `FMUL`, `FDIV`, `DADD`, `DSUB`, `DMUL`, `DDIV`.
  - Bitwise operations and shifts: `IAND`, `IOR`, `IXOR`, `ISHL`, `ISHR`, `IUSHR`.
  - Type conversions: `I2L`, `L2I`.
  - Invocations: `INVOKESTATIC`, `INVOKEVIRTUAL`.

## [0.1.0-alpha.3] - 2026-06-22

### Added
- Created `JVMAsmPrinter.cpp` for text-based bytecode/Jasmin assembly output.
- Added `JVMBytecodeFormats.td` defining JVM classfile attributes (`Code`, `ConstantValue`, `StackMapTable`, `LineNumberTable`, `SourceFile`).
- Updated `llvm/lib/Target/JVM/CMakeLists.txt` to link `AsmPrinter` component and include `JVMAsmPrinter.cpp`.

## [0.1.0-alpha.2] - 2026-06-22

### Added
- Created LLVM TableGen definition files for JVM backend target:
  - `llvm/lib/Target/JVM/JVMRegisterInfo.td`: Virtual registers (`R0`-`R3`, `L0`-`L1`, `F0`, `D0`) and register classes (`I32Regs`, `I64Regs`, `F32Regs`, `F64Regs`).
  - `llvm/lib/Target/JVM/JVMInstrInfo.td`: JVM bytecode instructions (`IADD`, `ISUB`, `IMUL`, `IDIV`, `IRETURN`, `RETURN`, `ILOAD`, `ISTORE`, `ALOAD`, `ASTORE`, `IFEQ`, `IFNE`, `GOTO`) with opcode definitions.
  - `llvm/lib/Target/JVM/JVMTargetProperties.td`: Subtarget feature flags (`FeatureJava21`, `FeaturePanama`, `FeatureUnsafe`).
  - `llvm/lib/Target/JVM/JVMInstructionSetMask.td`: Opcode classification categories (`CatConstant`, `CatLoadStore`, `CatArithmetic`, etc.).
  - `llvm/lib/Target/JVM/JVM.td`: Master target description with processor definitions (`generic`, `jvm21`).
- Updated `llvm/lib/Target/JVM/CMakeLists.txt` to trigger `tablegen` for `JVMGenSubtargetInfo.inc`, `JVMGenRegisterInfo.inc`, and `JVMGenInstrInfo.inc`, and export public TableGen target `JVMCommonTableGen`.

## [0.1.0-alpha.1] - 2026-06-22

### Added
- Registered `Triple::jvm` architecture enum in `llvm/include/llvm/TargetParser/Triple.h`.
- Implemented Triple parsing and string conversions in `llvm/lib/TargetParser/Triple.cpp`.
- Added data layout string definition for JVM target in `llvm/lib/TargetParser/TargetDataLayout.cpp`.
- Added `JVM` target to `LLVM_ALL_EXPERIMENTAL_TARGETS` in `llvm/CMakeLists.txt`.
- Created JVM backend skeleton under `llvm/lib/Target/JVM/`:
  - `JVMTargetMachine.h` and `JVMTargetMachine.cpp`
  - `JVMISelLowering.h` and `JVMISelLowering.cpp`
  - `JVMInstructionSelector.cpp`
  - `TargetInfo/JVMTargetInfo.h` and `TargetInfo/JVMTargetInfo.cpp`
  - Target CMake build configuration.
- Added Clang frontend support for `-target jvm`:
  - Defined `JVMTargetInfo` in `clang/lib/Basic/Targets/JVM.h`.
  - Registered target instantiation in `clang/lib/Basic/Targets.cpp`.
- Added comprehensive governance and architecture documentation: `VERSION.md`, `VISION.md`, `ROADMAP.md`, `TODO.md`, `MEMORY.md`, `DEPLOY.md`, `IDEAS.md`, and `HANDOFF.md`.

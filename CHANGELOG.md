# Changelog

All notable changes to this project are documented in this file.
The version format corresponds to `VERSION.md`.

## [0.1.0-alpha.2] - 2026-06-22

### Added
- Created LLVM TableGen definition files for JVM backend target:
  - `llvm/lib/Target/JVM/JVMRegisterInfo.td`: Virtual registers (`R0`-`R3`, `L0`-`L1`, `F0`, `D0`) and register classes (`I32Regs`, `I64Regs`, `F32Regs`, `F64Regs`).
  - `llvm/lib/Target/JVM/JVMInstrInfo.td`: JVM bytecode instructions (`IADD`, `ISUB`, `IMUL`, `IDIV`, `IRETURN`, `RETURN`) with opcode definitions.
  - `llvm/lib/Target/JVM/JVM.td`: Master target description including subtarget features (`FeatureJava21`, `FeaturePanama`, `FeatureUnsafe`) and processor definitions (`generic`, `jvm21`).
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

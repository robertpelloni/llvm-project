# Changelog

All notable changes to this project are documented in this file.
The version format corresponds to `VERSION.md`.

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

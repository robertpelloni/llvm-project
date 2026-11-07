# System & Codebase Memory: LLVM JVM Backend

## Architectural Observations
- **Repository Structure**: Monorepo containing `llvm`, `clang`, `lld`, `lldb`, `mlir`, and runtimes.
- **Experimental Target Policy**:
  - LLVM targets can be registered as experimental by adding the target directory name to `LLVM_ALL_EXPERIMENTAL_TARGETS` in `llvm/CMakeLists.txt`.
  - Targets are enabled via `-DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD="JVM"` during CMake configuration.
- **Triple Registration**:
  - `llvm/include/llvm/TargetParser/Triple.h`: Defines `ArchType::jvm`.
  - `llvm/lib/TargetParser/Triple.cpp`: Provides string serialization, parsing, pointer size, and default format resolution.
  - `llvm/lib/TargetParser/TargetDataLayout.cpp`: Provides the target data layout string `e-m:e-p:32:32-i64:64-n32:64-S128`.
- **Clang Target Integration**:
  - `clang/lib/Basic/Targets/JVM.h`: Implements `JVMTargetInfo` inheriting from `clang::TargetInfo`.
  - `clang/lib/Basic/Targets.cpp`: Instantiates `JVMTargetInfo` when `Triple.getArch() == llvm::Triple::jvm`.
- **JVM Bytecode Mapping Considerations**:
  - JVM execution is stack-based, whereas LLVM IR is register-based SSA.
  - MachineInstr emission for JVM requires translating register assignments to either JVM local variable indices (`iload`/`istore`) or stack operations.

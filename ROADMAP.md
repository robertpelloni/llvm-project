# LLVM JVM Target Backend: Structural Roadmap

## Milestone 1: Target Registration and Clang Toolchain Setup (Completed / In Progress)
- [x] Register `Triple::jvm` in `llvm/include/llvm/TargetParser/Triple.h`.
- [x] Implement triple parsing and string mappings in `llvm/lib/TargetParser/Triple.cpp`.
- [x] Define default data layout for JVM target in `llvm/lib/TargetParser/TargetDataLayout.cpp`.
- [x] Add `JVM` to `LLVM_ALL_EXPERIMENTAL_TARGETS` in `llvm/CMakeLists.txt`.
- [x] Implement target skeleton in `llvm/lib/Target/JVM/` (`JVMTargetMachine`, `JVMISelLowering`, `JVMInstructionSelector`, `TargetInfo/JVMTargetInfo`).
- [x] Register `-target jvm` in Clang (`clang/lib/Basic/Targets/JVM.h` and `Targets.cpp`).

## Milestone 2: MC Layer & Object File Writer for JVM Classfiles
- [ ] Implement `JVMObjectWriter` emitting JVM `.class` format (magic `0xCAFEBABE`, minor/major version 65.0 for Java 21+).
- [ ] Implement Constant Pool builder for classes, methods, utf8 strings, field references, and name-and-type descriptors.
- [ ] Implement Classfile attributes emission (`Code`, `StackMapTable`, `LineNumberTable`, `SourceFile`).

## Milestone 3: SelectionDAG & GlobalISel Lowering
- [ ] Complete arithmetic and bitwise operation lowering (i32, i64, f32, f64).
- [ ] Implement stack frame layout and local variable slot allocation (`locals` index management).
- [ ] Support branching and control flow: `ifeq`, `ifne`, `if_icmplt`, `goto`, `lookupswitch`, `tableswitch`.
- [ ] Function call ABI lowering: map C calling convention to JVM static methods (`invokestatic`).

## Milestone 4: Runtime Library Integration (`jvm-cpp-runtime`)
- [ ] Off-heap linear memory manager using Project Panama `MemorySegment` or `sun.misc.Unsafe`.
- [ ] Minimal C library runtime (malloc/free, memcpy/memset, printf/string formatting).
- [ ] POSIX and system call shims mapped to Java standard libraries (`java.nio.file`, `java.lang.System`).

## Milestone 5: Optimization Passes & Benchmark Suite
- [ ] Stack-depth minimization and peephole optimization for JVM bytecode.
- [ ] Elimination of redundant load/store sequences in JVM method bodies.
- [ ] Execution of test-suite benchmarks comparing native vs JVM backend output.

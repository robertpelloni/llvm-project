# LLVM JVM Target Backend: Vision & Foundational Design

## 1. Core Vision
The LLVM JVM target backend enables native C and C++ (and any LLVM IR frontend) codebases to be compiled directly into standard Java Virtual Machine (JVM) bytecode (`.class` files) and Java bytecode archives (`.jar`).

Instead of relying solely on heavy emulators, manual rewrites, or slow interpreters, the JVM backend provides a direct compilation pipeline:
- **Source Frontend**: Clang (C/C++), Rust, Swift, or other LLVM IR producers.
- **Middle-end**: LLVM optimization passes (`opt`).
- **Backend**: LLVM JVM Target (`llvm/lib/Target/JVM`) translating SelectionDAG / GlobalISel machine instructions into JVM stack-based bytecode and class structures.
- **Runtime Environment**: Standard Java SE / OpenJDK runtimes (HotSpot, OpenJ9) paired with `jvm-cpp-runtime` support libraries for memory emulation, pointer arithmetic, and native C standard library operations.

## 2. Architectural Pillars
1. **Direct Stack Bytecode Generation**:
   - Map LLVM IR operations directly to native JVM bytecodes (`iadd`, `isub`, `imul`, `idiv`, `iload`, `istore`, `invokevirtual`, `invokestatic`).
2. **Linear Memory & Pointer Safety**:
   - Provide flexible memory models:
     - *Direct Memory / Unsafe / Foreign Function & Memory API (Project Panama)*: High performance direct off-heap memory access via `java.lang.foreign.MemorySegment` or `sun.misc.Unsafe`.
     - *Emulated Heap Buffer (`byte[]` / `ByteBuffer`)*: Sandboxed, portable execution running purely on standard JVM heaps.
3. **Seamless Java Interoperability**:
   - Allow C/C++ functions to be invoked by Java code with minimal overhead.
   - Support calling Java class methods and APIs directly from C++ through typed binding headers.
4. **Integration with OpenJDK Ecosystem**:
   - Support standard OpenJDK targets (`-target jvm-unknown-unknown` or `-target jvm-openjdk`).

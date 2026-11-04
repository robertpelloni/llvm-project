# Deployment & Environment Setup Guide

## Requirements
- CMake >= 3.20.0
- Ninja >= 1.10.0
- C++17 compatible host compiler (Clang >= 16 or GCC >= 11)
- Python 3.8+
- JDK 21+ (for running generated JVM class files)

## Build Instructions

### Configuring LLVM with JVM Target
To build LLVM with the experimental JVM target:

```bash
mkdir build && cd build
cmake -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_ENABLE_PROJECTS="clang" \
  -DLLVM_TARGETS_TO_BUILD="X86" \
  -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD="JVM" \
  ../llvm
```

### Compiling Core JVM Backend Libraries
To build only the JVM target component libraries:

```bash
ninja LLVMJVMCodeGen LLVMJVMInfo
```

### Building Clang with JVM Target Support
```bash
ninja clang
```

### Compiling C Code to JVM Target
```bash
./bin/clang -target jvm -S test.c -o test.s
```

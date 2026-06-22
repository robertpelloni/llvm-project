with open("clang/lib/Basic/Targets.cpp", "r") as f:
    text = f.read()

text = text.replace("#include \"Targets/JVM.h\"\n#include \"Targets/JVM.h\"", "#include \"Targets/JVM.h\"")
text = text.replace("  case llvm::Triple::jvm:\n    return std::make_unique<JVMTargetInfo>(Triple, Opts);\n  case llvm::Triple::jvm:\n    return std::make_unique<JVMTargetInfo>(Triple, Opts);", "  case llvm::Triple::jvm:\n    return std::make_unique<JVMTargetInfo>(Triple, Opts);")

with open("clang/lib/Basic/Targets.cpp", "w") as f:
    f.write(text)

with open("llvm/include/llvm/TargetParser/Triple.h", "r") as f:
    text = f.read()

text = text.replace("    jvm,            // JVM: Java Virtual Machine\n    jvm,            // JVM: Java Virtual Machine", "    jvm,            // JVM: Java Virtual Machine")
with open("llvm/include/llvm/TargetParser/Triple.h", "w") as f:
    f.write(text)

with open("llvm/lib/Target/JVM/JVMTargetMachine.cpp", "r") as f:
    text = f.read()

text = text.replace("LLVMTargetMachine(T, \"e-m:e-p:32:32-i64:64-n32:64-S128\", TT, CPU, FS, Options, RM.value_or(Reloc::Static), CM.value_or(CodeModel::Small), OL)", "TargetMachine(T, \"e-m:e-p:32:32-i64:64-n32:64-S128\", TT, CPU, FS, Options)")
text = text.replace("TLOF(std::make_unique<TargetLoweringObjectFile>())", "TLOF(std::make_unique<TargetLoweringObjectFileELF>())")
text = text.replace("#include \"TargetInfo/JVMTargetInfo.h\"", "#include \"TargetInfo/JVMTargetInfo.h\"\n#include \"llvm/CodeGen/TargetLoweringObjectFileImpl.h\"")

with open("llvm/lib/Target/JVM/JVMTargetMachine.cpp", "w") as f:
    f.write(text)

with open("llvm/lib/Target/JVM/JVMTargetMachine.h", "r") as f:
    text = f.read()

text = text.replace("class JVMTargetMachine : public LLVMTargetMachine", "class JVMTargetMachine : public TargetMachine")
text = text.replace("class JVMSubtarget : public TargetSubtargetInfo {\npublic:\n  JVMSubtarget(const Triple &TT, StringRef CPU, StringRef FS, const TargetMachine &TM) \n    : TargetSubtargetInfo(TT, CPU, CPU, FS, ArrayRef<StringRef>(), ArrayRef<SubtargetFeatureKV>(), ArrayRef<SubtargetSubTypeKV>(), nullptr, nullptr, nullptr, nullptr, nullptr, nullptr) {}\n};", "class JVMSubtarget : public TargetSubtargetInfo {\npublic:\n  JVMSubtarget(const Triple &TT, StringRef CPU, StringRef FS, const TargetMachine &TM) \n    : TargetSubtargetInfo(TT, CPU, CPU, FS, ArrayRef<StringRef>(), ArrayRef<SubtargetFeatureKV>(), ArrayRef<SubtargetSubTypeKV>(), nullptr, nullptr, nullptr, nullptr, nullptr, nullptr) {}\n\n  const TargetRegisterInfo *getRegisterInfo() const override { return nullptr; }\n  const TargetInstrInfo *getInstrInfo() const override { return nullptr; }\n  const TargetFrameLowering *getFrameLowering() const override { return nullptr; }\n  const TargetLowering *getTargetLowering() const override { return nullptr; }\n  const SelectionDAGTargetInfo *getSelectionDAGInfo() const override { return nullptr; }\n};")

with open("llvm/lib/Target/JVM/JVMTargetMachine.h", "w") as f:
    f.write(text)

with open("llvm/lib/Target/JVM/TargetInfo/JVMTargetInfo.cpp", "r") as f:
    text = f.read()

text = text.replace("#include \"TargetInfo/JVMTargetInfo.h\"", "#include \"JVMTargetInfo.h\"")

with open("llvm/lib/Target/JVM/TargetInfo/JVMTargetInfo.cpp", "w") as f:
    f.write(text)

with open("llvm/lib/TargetParser/Triple.cpp", "r") as f:
    text = f.read()

text = text.replace("      .Case(\"jvm\", jvm)\n      .Case(\"jvm\", jvm)", "      .Case(\"jvm\", jvm)")
text = text.replace("          .Case(\"jvm\", Triple::jvm)\n          .Case(\"jvm\", Triple::jvm)", "          .Case(\"jvm\", Triple::jvm)")

with open("llvm/lib/TargetParser/Triple.cpp", "w") as f:
    f.write(text)

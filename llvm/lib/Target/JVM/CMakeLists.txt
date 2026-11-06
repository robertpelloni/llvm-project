add_llvm_component_group(JVM)

set(LLVM_TARGET_DEFINITIONS JVM.td)

tablegen(LLVM JVMGenSubtargetInfo.inc -gen-subtarget)
tablegen(LLVM JVMGenRegisterInfo.inc -gen-register-info)
tablegen(LLVM JVMGenInstrInfo.inc -gen-instr-info)

add_public_tablegen_target(JVMCommonTableGen)

add_llvm_target(LLVMJVMCodeGen
  JVMISelLowering.cpp
  JVMInstructionSelector.cpp
  JVMTargetMachine.cpp

  LINK_COMPONENTS
  Analysis
  CodeGen
  CodeGenTypes
  Core
  MC
  Support
  Target
  TargetParser
  JVMInfo

  ADD_TO_COMPONENT
  JVM

  DEPENDS
  JVMCommonTableGen
  )

add_subdirectory(TargetInfo)

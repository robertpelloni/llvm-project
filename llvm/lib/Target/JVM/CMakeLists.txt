add_llvm_component_group(JVM)
add_llvm_component_library(LLVMJVMCodeGen
  JVMISelLowering.cpp
  JVMInstructionSelector.cpp
  JVMTargetMachine.cpp

  LINK_COMPONENTS
  CodeGen
  Core
  MC
  Support
  Target
  JVMInfo

  ADD_TO_COMPONENT
  JVM
  )
add_subdirectory(TargetInfo)

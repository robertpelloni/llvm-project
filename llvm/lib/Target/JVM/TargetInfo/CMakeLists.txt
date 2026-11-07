add_llvm_component_library(LLVMJVMInfo
  JVMTargetInfo.cpp

  LINK_COMPONENTS
  MC
  Support

  ADD_TO_COMPONENT
  JVM
  )

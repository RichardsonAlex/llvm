//===-- MipsTargetInfo.cpp - Mips Target Implementation -------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "Mips.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/TargetRegistry.h"
using namespace llvm;

Target &llvm::getTheMipsTarget() {
  static Target TheMipsTarget;
  return TheMipsTarget;
}
Target &llvm::getTheMipselTarget() {
  static Target TheMipselTarget;
  return TheMipselTarget;
}
Target &llvm::getTheMips64Target() {
  static Target TheMips64Target;
  return TheMips64Target;
}
Target &llvm::getTheMips64elTarget() {
  static Target TheMips64elTarget;
  return TheMips64elTarget;
}
Target &llvm::getTheMipsCheriTarget() {
  static Target TheMipsCheriTarget;
  return TheMipsCheriTarget;
}

extern "C" void LLVMInitializeMipsTargetInfo() {
  RegisterTarget<Triple::mips,
                 /*HasJIT=*/true>
      X(getTheMipsTarget(), "mips", "Mips");

  RegisterTarget<Triple::mipsel,
                 /*HasJIT=*/true>
      Y(getTheMipselTarget(), "mipsel", "Mipsel");

  RegisterTarget<Triple::mips64,
                 /*HasJIT=*/true>
      A(getTheMips64Target(), "mips64", "Mips64 [experimental]");

  RegisterTarget<Triple::mips64el,
                 /*HasJIT=*/true>
      B(getTheMips64elTarget(), "mips64el", "Mips64el [experimental]");
  RegisterTarget<Triple::cheri,
        /*HasJIT=*/true> C(getTheMipsCheriTarget(), "cheri", "CHERI");
}

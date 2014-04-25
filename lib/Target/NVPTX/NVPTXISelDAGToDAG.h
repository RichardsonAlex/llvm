//===-- NVPTXISelDAGToDAG.h - A dag to dag inst selector for NVPTX --------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines an instruction selector for the NVPTX target.
//
//===----------------------------------------------------------------------===//

#include "NVPTX.h"
#include "NVPTXISelLowering.h"
#include "NVPTXRegisterInfo.h"
#include "NVPTXTargetMachine.h"
#include "llvm/CodeGen/SelectionDAGISel.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/Support/Compiler.h"
using namespace llvm;

namespace {

class LLVM_LIBRARY_VISIBILITY NVPTXDAGToDAGISel : public SelectionDAGISel {

  // If true, generate corresponding FPCONTRACT. This is
  // language dependent (i.e. CUDA and OpenCL works differently).
  bool doFMAF64;
  bool doFMAF32;
  bool doFMAF64AGG;
  bool doFMAF32AGG;
  bool allowFMA;

  // If true, generate mul.wide from sext and mul
  bool doMulWide;

  int getDivF32Level() const;
  bool usePrecSqrtF32() const;
  bool useF32FTZ() const;

public:
  explicit NVPTXDAGToDAGISel(NVPTXTargetMachine &tm,
                             CodeGenOpt::Level   OptLevel);

  // Pass Name
  virtual const char *getPassName() const {
    return "NVPTX DAG->DAG Pattern Instruction Selection";
  }

  const NVPTXSubtarget &Subtarget;

  virtual bool SelectInlineAsmMemoryOperand(
      const SDValue &Op, char ConstraintCode, std::vector<SDValue> &OutOps);
private:
// Include the pieces autogenerated from the target description.
#include "NVPTXGenDAGISel.inc"

  SDNode *Select(SDNode *N);
  SDNode *SelectIntrinsicNoChain(SDNode *N);
  SDNode *SelectTexSurfHandle(SDNode *N);
  SDNode *SelectLoad(SDNode *N);
  SDNode *SelectLoadVector(SDNode *N);
  SDNode *SelectLDGLDUVector(SDNode *N);
  SDNode *SelectStore(SDNode *N);
  SDNode *SelectStoreVector(SDNode *N);
  SDNode *SelectLoadParam(SDNode *N);
  SDNode *SelectStoreRetval(SDNode *N);
  SDNode *SelectStoreParam(SDNode *N);
  SDNode *SelectAddrSpaceCast(SDNode *N);
  SDNode *SelectTextureIntrinsic(SDNode *N);
  SDNode *SelectSurfaceIntrinsic(SDNode *N);
        
  inline SDValue getI32Imm(unsigned Imm) {
    return CurDAG->getTargetConstant(Imm, MVT::i32);
  }

  // Match direct address complex pattern.
  bool SelectDirectAddr(SDValue N, SDValue &Address);

  bool SelectADDRri_imp(SDNode *OpNode, SDValue Addr, SDValue &Base,
                        SDValue &Offset, MVT mvt);
  bool SelectADDRri(SDNode *OpNode, SDValue Addr, SDValue &Base,
                    SDValue &Offset);
  bool SelectADDRri64(SDNode *OpNode, SDValue Addr, SDValue &Base,
                      SDValue &Offset);

  bool SelectADDRsi_imp(SDNode *OpNode, SDValue Addr, SDValue &Base,
                        SDValue &Offset, MVT mvt);
  bool SelectADDRsi(SDNode *OpNode, SDValue Addr, SDValue &Base,
                    SDValue &Offset);
  bool SelectADDRsi64(SDNode *OpNode, SDValue Addr, SDValue &Base,
                      SDValue &Offset);

  bool ChkMemSDNodeAddressSpace(SDNode *N, unsigned int spN) const;

};
}

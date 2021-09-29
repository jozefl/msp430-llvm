//===-- MSP430InstrInfoExtended.td - MSP430X Instruction defs -------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes the MSP430X extended instructions in TableGen format.
//
//===----------------------------------------------------------------------===//

// TODO: Most extended instructions have a .A version that enables 20-bit
// operands. This requires support the large memory model to be implemented.
//
// Only the extended instructions that are useful in the small memory model
// (16-bit pointers) are implemented so far. Instructions like MOVX are not
// required in the small memory model, and have increased size/cycle count
// compared to their 430 versions.

def MSP430rram     : SDNode<"MSP430ISD::RRAM", SDTIntShiftOp>;
def MSP430rrum     : SDNode<"MSP430ISD::RRUM", SDTIntShiftOp>;
def MSP430rlam     : SDNode<"MSP430ISD::RLAM", SDTIntShiftOp>;

def MSP430rrax     : SDNode<"MSP430ISD::RRAX", SDTIntShiftOp>;
def MSP430rlax     : SDNode<"MSP430ISD::RLAX", SDTIntShiftOp>;
def MSP430rrux     : SDNode<"MSP430ISD::RRUX", SDTIntShiftOp>;

// Differentiate between rpt2 and rpt4 to catch shift counts in IIExtExcRot
// instructions that are too large.
def Rpt2ImmAsmOperand : AsmOperandClass {
  let Name = "Rpt2Imm";
  let RenderMethod = "addImmOperands";
}

def Rpt4ImmAsmOperand : AsmOperandClass {
  let Name = "Rpt4Imm";
  let RenderMethod = "addImmOperands";
}

def rpt2imm : Operand<i8>,
              ImmLeaf<i8, [{return Imm >= 1 && Imm <= 4;}]> {
  let ParserMatchClass = Rpt2ImmAsmOperand;
  let EncoderMethod = "getRpt2ImmOpValue";
  let DecoderMethod = "decodeRptImm";
}

def rpt4imm : Operand<i8>,
              ImmLeaf<i8, [{return Imm >= 1 && Imm <= 16;}]> {
  let ParserMatchClass = Rpt4ImmAsmOperand;
  let EncoderMethod = "getRpt4ImmOpValue";
  let DecoderMethod = "decodeRptImm";
}

//===----------------------------------------------------------------------===//
//  Shift Instructions
//
let Predicates = [HasMSP430X] in {
let Constraints = "$rs = $rd", Defs = [SR] in {
  multiclass IIExtExcRot<string Mnemonic, bits<2> OpCode, SDNode OpNode> {
    def _16 : IIExtExcRotForm16<OpCode,
                                (outs GR16:$rd), (ins GR16:$rs, rpt2imm:$cnt),
                                !strconcat(Mnemonic, "\t$cnt, $rd"),
                                [(set GR16:$rd, (OpNode GR16:$rs, (i8 rpt2imm:$cnt))),
                                (implicit SR)]>;
  }

  defm RRAM : IIExtExcRot<"rram", 0b01, MSP430rram>;
  defm RRUM : IIExtExcRot<"rrum", 0b11, MSP430rrum>;
  defm RLAM : IIExtExcRot<"rlam", 0b10, MSP430rlam>;

  multiclass IIExtRot<string Mnemonic, bits<3> OpCode, bit ZC, SDNode OpNode> {
    let RptCountFlag = 1 in {
      def _8  :  II8rExtended<OpCode, ZC, 0,
                              (outs GR8:$rd), (ins GR8:$rs, rpt4imm:$cnt),
                              !strconcat(Mnemonic, ".b\t$rd"),
                              [(set GR8:$rd, (OpNode GR8:$rs, (i8 rpt4imm:$cnt))),
                              (implicit SR)]>;
      def _16 : II16rExtended<OpCode, ZC, 0,
                              (outs GR16:$rd), (ins GR16:$rs, rpt4imm:$cnt),
                              !strconcat(Mnemonic, "\t$rd"),
                              [(set GR16:$rd, (OpNode GR16:$rs, (i8 rpt4imm:$cnt))),
                              (implicit SR)]>;
    }
  }
  defm RRAX : IIExtRot<"rrax", 0b010, 0, MSP430rrax>;
  // RRUX is encoded as RRCX with the ZC flag set.
  defm RRUX : IIExtRot<"rrux", 0b000, 1, MSP430rrux>;

  multiclass IExtRot<string Mnemonic, bits<4> OpCode, SDNode OpNode> {
    let RptCountFlag = 1 in {
      def _8  :  I8rExtended<OpCode, 0, 0,
                              (outs GR8:$rd), (ins GR8:$rs, rpt4imm:$cnt),
                              !strconcat(Mnemonic, ".b\t$rd"),
                              [(set GR8:$rd, (OpNode GR8:$rs, (i8 rpt4imm:$cnt))),
                              (implicit SR)]>;
      def _16 : I16rExtended<OpCode, 0, 0,
                              (outs GR16:$rd), (ins GR16:$rs, rpt4imm:$cnt),
                              !strconcat(Mnemonic, "\t$rd"),
                              [(set GR16:$rd, (OpNode GR16:$rs, (i8 rpt4imm:$cnt))),
                              (implicit SR)]>;
    }
  }

  // RLAX is encoded as ADDX.
  defm RLAX : IExtRot<"rlax", 0b0101, MSP430rlax>;

} // Defs = [SR], Constraints = "$rs = $rd"

// These aliases are required so the DAG node created from
// "rpt #<cnt> { <insn> <rd>" can be matched.
//
// When parsing the "rpt" directive and associated instruction, the repetition
// count is set up as the 2nd operand of the instruction. The default assembly
// string for these instructions only has one operand because the count is set
// separately by the rpt directive.
//
// The instructions don't actually have this format, so don't ever print them.
def : InstAlias<"rrax\t$rd, $cnt", (RRAX_16 GR16:$rd, rpt4imm:$cnt), 0>;
def : InstAlias<"rrux\t$rd, $cnt", (RRUX_16 GR16:$rd, rpt4imm:$cnt), 0>;
def : InstAlias<"rlax\t$rd, $cnt", (RLAX_16 GR16:$rd, rpt4imm:$cnt), 0>;
def : InstAlias<"rrax.b\t$rd, $cnt", (RRAX_8 GR8:$rd, rpt4imm:$cnt), 0>;
def : InstAlias<"rrux.b\t$rd, $cnt", (RRUX_8 GR8:$rd, rpt4imm:$cnt), 0>;
def : InstAlias<"rlax.b\t$rd, $cnt", (RLAX_8 GR8:$rd, rpt4imm:$cnt), 0>;
} // Predicates = [HasMSP430X]

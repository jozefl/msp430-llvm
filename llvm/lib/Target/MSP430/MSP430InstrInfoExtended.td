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

def Rpt2ImmAsmOperand : AsmOperandClass {
  let Name = "Rpt2Imm";
  let RenderMethod = "addImmOperands";
}

def rpt2imm : Operand<i8>,
              ImmLeaf<i8, [{return Imm >= 1 && Imm <= 4;}]> {
  let ParserMatchClass = Rpt2ImmAsmOperand;
  let EncoderMethod = "getRpt2ImmOpValue";
  let DecoderMethod = "decodeRptImm";
}

//===----------------------------------------------------------------------===//
//  Shift Instructions
//
let Predicates = [HasMSP430X] in {
let Constraints = "$rs = $rd", Defs = [SR] in {
  multiclass IIExtExcRot<string Mnemonic, bits<2> OpCode> {
    def _16 : IIExtExcRotForm16<OpCode,
                                (outs GR16:$rd), (ins GR16:$rs, rpt2imm:$cnt),
                                !strconcat(Mnemonic, "\t$cnt, $rd"), []>;
  }

  defm RRAM : IIExtExcRot<"rram", 0b01>;
  defm RRUM : IIExtExcRot<"rrum", 0b11>;
  defm RLAM : IIExtExcRot<"rlam", 0b10>;

  multiclass IIExtRot<string Mnemonic, bits<3> OpCode, bit ZC> {
    def _8  :  II8rExtended<OpCode, ZC, 0,
                            (outs GR8:$rd), (ins GR8:$rs),
                            !strconcat(Mnemonic, ".b\t$rd"), []>;
    def _16 : II16rExtended<OpCode, ZC, 0,
                            (outs GR16:$rd), (ins GR16:$rs),
                            !strconcat(Mnemonic, "\t$rd"), []>;
  }
  defm RRAX : IIExtRot<"rrax", 0b010, 0>;
  // RRUX is encoded as RRCX with the ZC flag set.
  defm RRUX : IIExtRot<"rrux", 0b000, 1>;

  multiclass IExtRot<string Mnemonic, bits<4> OpCode> {
    def _8  :  I8rExtended<OpCode, 0, 0,
                            (outs GR8:$rd), (ins GR8:$rs),
                            !strconcat(Mnemonic, ".b\t$rd"), []>;
    def _16 : I16rExtended<OpCode, 0, 0,
                            (outs GR16:$rd), (ins GR16:$rs),
                            !strconcat(Mnemonic, "\t$rd"), []>;
  }

  // RLAX is encoded as ADDX.
  defm RLAX : IExtRot<"rlax", 0b0101>;

} // Defs = [SR], Constraints = "$rs = $rd"
} // Predicates = [HasMSP430X]

//===-- MSP430InstrFormats.td - MSP430 Instruction Formats -*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
//  Describe MSP430 instructions format here
//

class SourceMode<bits<2> val> {
  bits<2> Value = val;
}

def SrcReg      : SourceMode<0>; // r
def SrcMem      : SourceMode<1>; // m
def SrcIndReg   : SourceMode<2>; // n
def SrcPostInc  : SourceMode<3>; // p
def SrcImm      : SourceMode<3>; // i
//  SrcCGImm    : SourceMode< >; // c

class DestMode<bit val> {
  bit Value = val;
}

def DstReg      : DestMode<0>;   // r
def DstMem      : DestMode<1>;   // m

class ALKind<bit val> {
  bit Value = val;
}

def ALAddr : ALKind<0>;
def ALWord : ALKind<1>;

// Generic MSP430 Format
class MSP430Inst<dag outs, dag ins, int size, string asmstr> : Instruction {
  field bits<64> Inst;
  field bits<64> SoftFail = 0;

  let Namespace = "MSP430";

  dag OutOperandList = outs;
  dag InOperandList  = ins;

  let AsmString = asmstr;
  let Size = size;

  bit ExtensionWordFlag = 0;
  let TSFlags{0} = ExtensionWordFlag;
}

// MSP430 Double Operand (Format I) Instructions
class IForm<bits<4> opcode, DestMode ad, bit bw, SourceMode as, int size,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : MSP430Inst<outs, ins, size, asmstr> {
  let Pattern = pattern;

  bits<4> rs;
  bits<4> rd;

  let Inst{15-12} = opcode;
  let Inst{11-8}  = rs;
  let Inst{7}     = ad.Value;
  let Inst{6}     = bw;
  let Inst{5-4}   = as.Value;
  let Inst{3-0}   = rd;
}

// 8 bit IForm instructions
class IForm8<bits<4> opcode, DestMode dest, SourceMode src, int size,
             dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm<opcode, dest, 1, src, size, outs, ins, asmstr, pattern>;

class I8rr<bits<4> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm8<opcode, DstReg, SrcReg, 2, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Alpha";
}

class I8ri<bits<4> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm8<opcode, DstReg, SrcImm, 4, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Gamma";
  bits<16> imm;
  let Inst{31-16} = imm;
  let rs = 0b0000;
}

class I8rc<bits<4> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : MSP430Inst<outs, ins, 2, asmstr> {
  let DecoderNamespace = "Beta";
  let Pattern = pattern;

  bits<6> imm;
  bits<4> rd;

  let Inst{15-12} = opcode;
  let Inst{11-8}  = imm{3-0};
  let Inst{7}     = DstReg.Value;
  let Inst{6}     = 1;
  let Inst{5-4}   = imm{5-4};
  let Inst{3-0}   = rd;
}

class I8rm<bits<4> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm8<opcode, DstReg, SrcMem, 4, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Gamma";
  bits<20> src;
  let rs = src{3-0};
  let Inst{31-16} = src{19-4};
}

class I8rn<bits<4> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm8<opcode, DstReg, SrcIndReg, 2, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Delta";
}

class I8rp<bits<4> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm8<opcode, DstReg, SrcPostInc, 2, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Delta";
}

class I8mr<bits<4> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm8<opcode, DstMem, SrcReg, 4, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Alpha";
  bits<20> dst;
  let rd = dst{3-0};
  let Inst{31-16} = dst{19-4};
}

class I8mi<bits<4> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm8<opcode, DstMem, SrcImm, 6, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Gamma";
  bits<16> imm;
  bits<20> dst;
  let rs = 0b0000;
  let Inst{31-16} = imm;
  let rd = dst{3-0};
  let Inst{47-32} = dst{19-4};
}

class I8mc<bits<4> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : MSP430Inst<outs, ins, 4, asmstr> {
  let DecoderNamespace = "Beta";
  let Pattern = pattern;

  bits<6> imm;
  bits<20> dst;

  let Inst{31-16} = dst{19-4};
  let Inst{15-12} = opcode;
  let Inst{11-8}  = imm{3-0};
  let Inst{7}     = DstMem.Value;
  let Inst{6}     = 1;
  let Inst{5-4}   = imm{5-4};
  let Inst{3-0}   = dst{3-0};
}

class I8mm<bits<4> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm8<opcode, DstMem, SrcMem, 6, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Gamma";
  bits<20> src;
  bits<20> dst;
  let rs = src{3-0};
  let Inst{31-16} = src{19-4};
  let rd = dst{3-0};
  let Inst{47-32} = dst{19-4};
}

class I8mn<bits<4> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm8<opcode, DstMem, SrcIndReg, 4, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Delta";
  bits<20> dst;
  let rd = dst{3-0};
  let Inst{31-16} = dst{19-4};
}

class I8mp<bits<4> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm8<opcode, DstMem, SrcPostInc, 4, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Delta";
  bits<20> dst;
  let rd = dst{3-0};
  let Inst{31-16} = dst{19-4};
}

// 16 bit IForm instructions
class IForm16<bits<4> opcode, DestMode dest, SourceMode src, int size,
              dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm<opcode, dest, 0, src, size, outs, ins, asmstr, pattern>;

class I16rr<bits<4> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm16<opcode, DstReg, SrcReg, 2, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Alpha";
}

class I16ri<bits<4> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm16<opcode, DstReg, SrcImm, 4, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Gamma";
  bits<16> imm;
  let Inst{31-16} = imm;
  let rs = 0b0000;
}

class I16rc<bits<4> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : MSP430Inst<outs, ins, 2, asmstr> {
  let DecoderNamespace = "Beta";
  let Pattern = pattern;

  bits<6> imm;
  bits<4> rd;

  let Inst{15-12} = opcode;
  let Inst{11-8}  = imm{3-0};
  let Inst{7}     = DstReg.Value;
  let Inst{6}     = 0;
  let Inst{5-4}   = imm{5-4};
  let Inst{3-0}   = rd;
}

class I16rm<bits<4> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm16<opcode, DstReg, SrcMem, 4, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Gamma";
  bits<20> src;
  let rs = src{3-0};
  let Inst{31-16} = src{19-4};
}

class I16rn<bits<4> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm16<opcode, DstReg, SrcIndReg, 2, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Delta";
}

class I16rp<bits<4> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm16<opcode, DstReg, SrcPostInc, 2, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Delta";
}

class I16mr<bits<4> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm16<opcode, DstMem, SrcReg, 4, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Alpha";
  bits<20> dst;
  let rd = dst{3-0};
  let Inst{31-16} = dst{19-4};
}

class I16mi<bits<4> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm16<opcode, DstMem, SrcImm, 6, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Gamma";
  bits<16> imm;
  bits<20> dst;
  let Inst{31-16} = imm;
  let rs = 0b0000;
  let rd = dst{3-0};
  let Inst{47-32} = dst{19-4};
}

class I16mc<bits<4> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : MSP430Inst<outs, ins, 4, asmstr> {
  let DecoderNamespace = "Beta";
  let Pattern = pattern;

  bits<6> imm;
  bits<20> dst;

  let Inst{31-16} = dst{19-4};
  let Inst{15-12} = opcode;
  let Inst{11-8}  = imm{3-0};
  let Inst{7}     = DstMem.Value;
  let Inst{6}     = 0;
  let Inst{5-4}   = imm{5-4};
  let Inst{3-0}   = dst{3-0};
}

class I16mm<bits<4> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm16<opcode, DstMem, SrcMem, 6, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Gamma";
  bits<20> src;
  bits<20> dst;
  let rs = src{3-0};
  let Inst{31-16} = src{19-4};
  let rd = dst{3-0};
  let Inst{47-32} = dst{19-4};
}

class I16mn<bits<4> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm16<opcode, DstMem, SrcIndReg, 4, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Delta";
  bits<20> dst;
  let rd = dst{3-0};
  let Inst{31-16} = dst{19-4};
}

class I16mp<bits<4> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm16<opcode, DstMem, SrcPostInc, 4, outs, ins, asmstr, pattern> {
  let DecoderNamespace = "Delta";
  bits<20> dst;
  let rd = dst{3-0};
  let Inst{31-16} = dst{19-4};
}

// MSP430 Single Operand (Format II) Instructions
class IIForm<bits<3> opcode, bit bw, SourceMode as, int size,
             dag outs, dag ins, string asmstr, list<dag> pattern>
  : MSP430Inst<outs, ins, size, asmstr> {
  let Pattern = pattern;

  bits<4> rs;

  let Inst{15-10} = 0b000100;
  let Inst{9-7}   = opcode;
  let Inst{6}     = bw;
  let Inst{5-4}   = as.Value;
  let Inst{3-0}   = rs;
}

// 8 bit IIForm instructions
class IIForm8<bits<3> opcode, SourceMode src, int size,
              dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIForm<opcode, 1, src, size, outs, ins, asmstr, pattern>;

class II8r<bits<3> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIForm8<opcode, SrcReg, 2, outs, ins, asmstr, pattern>;

class II8m<bits<3> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIForm8<opcode, SrcMem, 4, outs, ins, asmstr, pattern> {
  bits<20> src;
  let rs = src{3-0};
  let Inst{31-16} = src{19-4};
}

class II8i<bits<3> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIForm8<opcode, SrcImm, 4, outs, ins, asmstr, pattern> {
  bits<16> imm;
  let rs = 0b0000;
  let Inst{31-16} = imm;
}

class II8c<bits<3> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : MSP430Inst<outs, ins, 2, asmstr> {
  let Pattern = pattern;

  bits<6> imm;

  let Inst{15-10} = 0b000100;
  let Inst{9-7}   = opcode;
  let Inst{6}     = 1;
  let Inst{5-0}   = imm;
}

class II8n<bits<3> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIForm8<opcode, SrcIndReg, 2, outs, ins, asmstr, pattern>;

class II8p<bits<3> opcode,
           dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIForm8<opcode, SrcPostInc, 2, outs, ins, asmstr, pattern>;

// 16 bit IIForm instructions
class IIForm16<bits<3> opcode, SourceMode src, int size,
               dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIForm<opcode, 0, src, size, outs, ins, asmstr, pattern>;

class II16r<bits<3> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIForm16<opcode, SrcReg, 2, outs, ins, asmstr, pattern>;

class II16m<bits<3> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIForm16<opcode, SrcMem, 4, outs, ins, asmstr, pattern> {
  bits<20> src;
  let rs = src{3-0};
  let Inst{31-16} = src{19-4};
}

class II16i<bits<3> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIForm16<opcode, SrcImm, 4, outs, ins, asmstr, pattern> {
  bits<16> imm;
  let rs = 0b0000;
  let Inst{31-16} = imm;
}

class II16c<bits<3> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : MSP430Inst<outs, ins, 2, asmstr> {
  let Pattern = pattern;

  bits<6> imm;

  let Inst{15-10} = 0b000100;
  let Inst{9-7}   = opcode;
  let Inst{6}     = 0;
  let Inst{5-0}   = imm;
}

class II16n<bits<3> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIForm16<opcode, SrcIndReg, 2, outs, ins, asmstr, pattern>;

class II16p<bits<3> opcode,
            dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIForm16<opcode, SrcPostInc, 2, outs, ins, asmstr, pattern>;

// MSP430 Conditional Jumps Instructions
class CJForm<dag outs, dag ins, string asmstr, list<dag> pattern>
  : MSP430Inst<outs, ins, 2, asmstr> {
  let Pattern = pattern;
  
  bits<3> cond;
  bits<10> dst;

  let Inst{15-13} = 0b001;
  let Inst{12-10} = cond;
  let Inst{9-0} = dst;
}

// MSP430 Extended Format II Instruction Format Exception - Rotation.
class IIExtExcRotForm<bits<2> opcode, ALKind al,
                   dag outs, dag ins, string asmstr, list<dag> pattern>
  : MSP430Inst<outs, ins, 2, asmstr> {
  let Pattern = pattern;

  bits<4> rd;
  bits<2> cnt;

  let Inst{15-12} = 0b0000;
  let Inst{11-10} = cnt;
  let Inst{9-8}   = opcode;
  let Inst{7-5}   = 0b010;
  let Inst{4}     = al.Value;
  let Inst{3-0}   = rd;
}

class IIExtExcRotForm16<bits<2> opcode, dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIExtExcRotForm<opcode, ALWord, outs, ins, asmstr, pattern>;

// The 430X extension word for register addressing modes.
//
// MSP430MCCodeEmitter expects the ExtensionWord field to be positioned at bits
// [63:48] of the Inst field in the MSP430Inst that the instruction corresponds
// to. encodeInstruction will rearrange the bits of the instruction to ensure
// the ExtensionWord is positioned correctly in the final binary encoding.
//
// Until the MSP430 large memory model is supported, there's no benefit to using
// non-register mode extended instructions, so they are not currently
// implemented.
class ExtensionWordRegForm<bit zc, bit rpt, ALKind al> {
  bits<16> ExtensionWord;
  bits<4> cnt = 0;

  let ExtensionWord{15-9} = 0b0001100;
  let ExtensionWord{8} = zc;
  let ExtensionWord{7} = rpt;
  let ExtensionWord{6} = al.Value;
  let ExtensionWord{5-4} = 0b00;
  let ExtensionWord{3-0} = cnt;
}

class II16rExtended<bits<3> opcode, bit zc, bit rpt,
                  dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIForm16<opcode, SrcReg, 4, outs, ins, asmstr, pattern>,
    ExtensionWordRegForm<zc, rpt, ALWord> {
  let Pattern = pattern;
  let ExtensionWordFlag = 1;
  let Inst{63-48} = ExtensionWord;
}

class I16rExtended<bits<4> opcode, bit zc, bit rpt,
                  dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm16<opcode, DstReg, SrcReg, 4, outs, ins, asmstr, pattern>,
    ExtensionWordRegForm<zc, rpt, ALWord> {
  let Pattern = pattern;
  let ExtensionWordFlag = 1;
  let Inst{63-48} = ExtensionWord;
}

class II8rExtended<bits<3> opcode, bit zc, bit rpt,
                  dag outs, dag ins, string asmstr, list<dag> pattern>
  : IIForm8<opcode, SrcReg, 4, outs, ins, asmstr, pattern>,
    ExtensionWordRegForm<zc, rpt, ALWord> {
  let Pattern = pattern;
  let ExtensionWordFlag = 1;
  let Inst{63-48} = ExtensionWord;
}

class I8rExtended<bits<4> opcode, bit zc, bit rpt,
                  dag outs, dag ins, string asmstr, list<dag> pattern>
  : IForm8<opcode, DstReg, SrcReg, 4, outs, ins, asmstr, pattern>,
    ExtensionWordRegForm<zc, rpt, ALWord> {
  let Pattern = pattern;
  let ExtensionWordFlag = 1;
  let Inst{63-48} = ExtensionWord;
}

// Pseudo instructions
class Pseudo<dag outs, dag ins, string asmstr, list<dag> pattern>
  : MSP430Inst<outs, ins, 0, asmstr> {
  let Pattern = pattern;
}

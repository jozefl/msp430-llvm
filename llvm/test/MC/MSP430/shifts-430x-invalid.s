// Tests to check for incorrect use of MSP430X shift instructions.
// RUN: not llvm-mc --triple=msp430 -mcpu=msp430x < %s 2>&1 | FileCheck %s

foo:
// Check for an error when the reptition count is too large.
  rrum #5, r12
  rram #5, r12
  rlam #5, r12
// CHECK: :8: error: invalid operand for instruction
// CHECK: :8: error: invalid operand for instruction
// CHECK: :8: error: invalid operand for instruction

// Check for an error when the reptition count is too large.
  rpt #17 { rrux r12
  rpt #17 { rrax r12
  rpt #17 { rlax r12
// CHECK: :7: error: invalid repetition count
// CHECK: :7: error: invalid repetition count
// CHECK: :7: error: invalid repetition count

// Check for an error when RxxX shifts have a shift amount operand.
  rrux #3, r12
  rrax #3, r12
  rlax #3, r12
// CHECK: :8: error: invalid operand for instruction
// CHECK: :8: error: invalid operand for instruction
// CHECK: :8: error: invalid operand for instruction

// Check for an error when there is no separator between rpt and the extended
// instruction.
  rpt #3 rrux r12
  rpt #3 rrax r12
  rpt #3 rlax r12
// CHECK: :10: error: expected '{' or a newline after "rpt #<imm>"
// CHECK: :10: error: expected '{' or a newline after "rpt #<imm>"
// CHECK: :10: error: expected '{' or a newline after "rpt #<imm>"

// Check that rpt cannot be used with RxxM shifts.
  rpt #3 { rrum #3, r12
  rpt #3 { rram #3, r12
  rpt #3 { rlam #3, r12
// CHECK: :19: error: only one operand expected
// CHECK: :19: error: only one operand expected
// CHECK: :19: error: only one operand expected

// Check that rpt cannot be used with 430 instructions.
  rpt #3 { rrc r12
  rpt #3 { rra r12
  rpt #3 { rla r12
// CHECK: :7: error: invalid operand for instruction
// CHECK: :7: error: invalid operand for instruction
// CHECK: :7: error: invalid operand for instruction

// Check that the operand to rpt must be an immediate.
  rpt foo    { rrux r12
  rpt r13    { rrax r12
  rpt @r13   { rrax r12
  rpt &bar   { rrax r12
  rpt 2(r14) { rlax r12
// CHECK: :7: error: expected immediate operand
// CHECK: :7: error: expected immediate operand
// CHECK: :7: error: expected immediate operand
// CHECK: :7: error: expected immediate operand
// CHECK: :7: error: expected immediate operand

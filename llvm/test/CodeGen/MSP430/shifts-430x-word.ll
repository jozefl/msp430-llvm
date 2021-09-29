; Tests for constant shifts of 16-bit register operands, for the 430X CPU.
;
; RUN: llc -mcpu=msp430x < %s | FileCheck %s
target datalayout = "e-p:16:8:8-i8:8:8-i16:8:8-i32:8:8-n8:16"
target triple = "msp430-elf"

;; Tests for logical right shifts.
define i16 @lshr1(i16 %value) {
; CHECK-LABEL: lshr1:
; CHECK: rrum #1, r12
  %result = lshr i16 %value, 1
  ret i16 %result
}

define i16 @lshr2(i16 %value) {
; CHECK-LABEL: lshr2:
; CHECK: rrum #2, r12
  %result = lshr i16 %value, 2
  ret i16 %result
}

define i16 @lshr3(i16 %value) {
; CHECK-LABEL: lshr3:
; CHECK: rrum #3, r12
  %result = lshr i16 %value, 3
  ret i16 %result
}

define i16 @lshr4(i16 %value) {
; CHECK-LABEL: lshr4:
; CHECK: rrum #4, r12
  %result = lshr i16 %value, 4
  ret i16 %result
}

define i16 @lshr5(i16 %value) {
; CHECK-LABEL: lshr5:
; CHECK: rrum #4, r12
; CHECK-NEXT: rrum #1, r12
  %result = lshr i16 %value, 5
  ret i16 %result
}

define i16 @lshr6(i16 %value) {
; CHECK-LABEL: lshr6:
; CHECK: rrum #4, r12
; CHECK-NEXT: rrum #2, r12
  %result = lshr i16 %value, 6
  ret i16 %result
}

define i16 @lshr7(i16 %value) {
; CHECK-LABEL: lshr7:
; CHECK: rrum #4, r12
; CHECK-NEXT: rrum #3, r12
  %result = lshr i16 %value, 7
  ret i16 %result
}

define i16 @lshr8(i16 %value) {
; CHECK-LABEL: lshr8:
; CHECK: swpb r12
; CHECK-NEXT: mov.b r12, r12
  %result = lshr i16 %value, 8
  ret i16 %result
}

define i16 @lshr9(i16 %value) {
; CHECK-LABEL: lshr9:
; CHECK: swpb r12
; CHECK-NEXT: mov.b r12, r12
; CHECK-NEXT: rrum #1, r12
  %result = lshr i16 %value, 9
  ret i16 %result
}

define i16 @lshr10(i16 %value) {
; CHECK-LABEL: lshr10:
; CHECK: swpb r12
; CHECK-NEXT: mov.b r12, r12
; CHECK-NEXT: rrum #2, r12
  %result = lshr i16 %value, 10
  ret i16 %result
}

define i16 @lshr11(i16 %value) {
; CHECK-LABEL: lshr11:
; CHECK: swpb r12
; CHECK-NEXT: mov.b r12, r12
; CHECK-NEXT: rrum #3, r12
  %result = lshr i16 %value, 11
  ret i16 %result
}

define i16 @lshr12(i16 %value) {
; CHECK-LABEL: lshr12:
; CHECK: swpb r12
; CHECK-NEXT: mov.b r12, r12
; CHECK-NEXT: rrum #4, r12
  %result = lshr i16 %value, 12
  ret i16 %result
}

define i16 @lshr13(i16 %value) {
; CHECK-LABEL: lshr13:
; CHECK: swpb r12
; CHECK-NEXT: mov.b r12, r12
; CHECK-NEXT: rrum #4, r12
; CHECK-NEXT: rrum #1, r12
  %result = lshr i16 %value, 13
  ret i16 %result
}

define i16 @lshr14(i16 %value) {
; CHECK-LABEL: lshr14:
; CHECK: swpb r12
; CHECK-NEXT: mov.b r12, r12
; CHECK-NEXT: rrum #4, r12
; CHECK-NEXT: rrum #2, r12
  %result = lshr i16 %value, 14
  ret i16 %result
}

define i16 @lshr15(i16 %value) {
; CHECK-LABEL: lshr15:
; CHECK: swpb r12
; CHECK-NEXT: mov.b r12, r12
; CHECK-NEXT: rrum #4, r12
; CHECK-NEXT: rrum #3, r12
  %result = lshr i16 %value, 15
  ret i16 %result
}

define i16 @lshr16(i16 %value) {
; CHECK-LABEL: lshr16:
; CHECK-NOT: rrum
; CHECK-NOT: rrux
  %result = lshr i16 %value, 16
  ret i16 %result
}

;; Tests for arithmetic right shifts.
define i16 @ashr1(i16 %value) {
; CHECK-LABEL: ashr1:
; CHECK: rra r12
  %result = ashr i16 %value, 1
  ret i16 %result
}

define i16 @ashr2(i16 %value) {
; CHECK-LABEL: ashr2:
; CHECK: rram #2, r12
  %result = ashr i16 %value, 2
  ret i16 %result
}

define i16 @ashr3(i16 %value) {
; CHECK-LABEL: ashr3:
; CHECK: rram #3, r12
  %result = ashr i16 %value, 3
  ret i16 %result
}

define i16 @ashr4(i16 %value) {
; CHECK-LABEL: ashr4:
; CHECK: rram #4, r12
  %result = ashr i16 %value, 4
  ret i16 %result
}

define i16 @ashr5(i16 %value) {
; CHECK-LABEL: ashr5:
; CHECK: rram #4, r12
; CHECK-NEXT: rram #1, r12
  %result = ashr i16 %value, 5
  ret i16 %result
}

define i16 @ashr6(i16 %value) {
; CHECK-LABEL: ashr6:
; CHECK: rram #4, r12
; CHECK-NEXT: rram #2, r12
  %result = ashr i16 %value, 6
  ret i16 %result
}

define i16 @ashr7(i16 %value) {
; CHECK-LABEL: ashr7:
; CHECK: rram #4, r12
; CHECK-NEXT: rram #3, r12
  %result = ashr i16 %value, 7
  ret i16 %result
}

define i16 @ashr8(i16 %value) {
; CHECK-LABEL: ashr8:
; CHECK: swpb r12
; CHECK-NEXT: sxt r12
  %result = ashr i16 %value, 8
  ret i16 %result
}

define i16 @ashr9(i16 %value) {
; CHECK-LABEL: ashr9:
; CHECK: swpb r12
; CHECK-NEXT: sxt r12
; CHECK-NEXT: rram #1, r12
  %result = ashr i16 %value, 9
  ret i16 %result
}

define i16 @ashr10(i16 %value) {
; CHECK-LABEL: ashr10:
; CHECK: swpb r12
; CHECK-NEXT: sxt r12
; CHECK-NEXT: rram #2, r12
  %result = ashr i16 %value, 10
  ret i16 %result
}

define i16 @ashr11(i16 %value) {
; CHECK-LABEL: ashr11:
; CHECK: swpb r12
; CHECK-NEXT: sxt r12
; CHECK-NEXT: rram #3, r12
  %result = ashr i16 %value, 11
  ret i16 %result
}

define i16 @ashr12(i16 %value) {
; CHECK-LABEL: ashr12:
; CHECK: swpb r12
; CHECK-NEXT: sxt r12
; CHECK-NEXT: rram #4, r12
  %result = ashr i16 %value, 12
  ret i16 %result
}

define i16 @ashr13(i16 %value) {
; CHECK-LABEL: ashr13:
; CHECK: swpb r12
; CHECK-NEXT: sxt r12
; CHECK-NEXT: rram #4, r12
; CHECK-NEXT: rram #1, r12
  %result = ashr i16 %value, 13
  ret i16 %result
}

define i16 @ashr14(i16 %value) {
; CHECK-LABEL: ashr14:
; CHECK: swpb r12
; CHECK-NEXT: sxt r12
; CHECK-NEXT: rram #4, r12
; CHECK-NEXT: rram #2, r12
  %result = ashr i16 %value, 14
  ret i16 %result
}

define i16 @ashr15(i16 %value) {
; CHECK-LABEL: ashr15:
; CHECK: swpb r12
; CHECK-NEXT: sxt r12
; CHECK-NEXT: rram #4, r12
; CHECK-NEXT: rram #3, r12
  %result = ashr i16 %value, 15
  ret i16 %result
}

define i16 @ashr16(i16 %value) {
; CHECK-LABEL: ashr16:
; CHECK-NOT: rram
; CHECK-NOT: rrax
  %result = ashr i16 %value, 16
  ret i16 %result
}

;; Tests for logical left shifts.
define i16 @shl1(i16 %value) {
; CHECK-LABEL: shl1:
; CHECK: add r12, r12
  %result = shl i16 %value, 1
  ret i16 %result
}

define i16 @shl2(i16 %value) {
; CHECK-LABEL: shl2:
; CHECK: rlam #2, r12
  %result = shl i16 %value, 2
  ret i16 %result
}

define i16 @shl3(i16 %value) {
; CHECK-LABEL: shl3:
; CHECK: rlam #3, r12
  %result = shl i16 %value, 3
  ret i16 %result
}

define i16 @shl4(i16 %value) {
; CHECK-LABEL: shl4:
; CHECK: rlam #4, r12
  %result = shl i16 %value, 4
  ret i16 %result
}

define i16 @shl5(i16 %value) {
; CHECK-LABEL: shl5:
; CHECK: rlam #4, r12
; CHECK-NEXT: rlam #1, r12
  %result = shl i16 %value, 5
  ret i16 %result
}

define i16 @shl6(i16 %value) {
; CHECK-LABEL: shl6:
; CHECK: rlam #4, r12
; CHECK-NEXT: rlam #2, r12
  %result = shl i16 %value, 6
  ret i16 %result
}

define i16 @shl7(i16 %value) {
; CHECK-LABEL: shl7:
; CHECK: rlam #4, r12
; CHECK-NEXT: rlam #3, r12
  %result = shl i16 %value, 7
  ret i16 %result
}

define i16 @shl8(i16 %value) {
; CHECK-LABEL: shl8:
; CHECK: mov.b r12, r12
; CHECK-NEXT: swpb r12
  %result = shl i16 %value, 8
  ret i16 %result
}

define i16 @shl9(i16 %value) {
; CHECK-LABEL: shl9:
; CHECK: mov.b r12, r12
; CHECK-NEXT: swpb r12
; CHECK-NEXT: rlam #1, r12
  %result = shl i16 %value, 9
  ret i16 %result
}

define i16 @shl10(i16 %value) {
; CHECK-LABEL: shl10:
; CHECK: mov.b r12, r12
; CHECK-NEXT: swpb r12
; CHECK-NEXT: rlam #2, r12
  %result = shl i16 %value, 10
  ret i16 %result
}

define i16 @shl11(i16 %value) {
; CHECK-LABEL: shl11:
; CHECK: mov.b r12, r12
; CHECK-NEXT: swpb r12
; CHECK-NEXT: rlam #3, r12
  %result = shl i16 %value, 11
  ret i16 %result
}

define i16 @shl12(i16 %value) {
; CHECK-LABEL: shl12:
; CHECK: mov.b r12, r12
; CHECK-NEXT: swpb r12
; CHECK-NEXT: rlam #4, r12
  %result = shl i16 %value, 12
  ret i16 %result
}

define i16 @shl13(i16 %value) {
; CHECK-LABEL: shl13:
; CHECK: mov.b r12, r12
; CHECK-NEXT: swpb r12
; CHECK-NEXT: rlam #4, r12
; CHECK-NEXT: rlam #1, r12
  %result = shl i16 %value, 13
  ret i16 %result
}

define i16 @shl14(i16 %value) {
; CHECK-LABEL: shl14:
; CHECK: mov.b r12, r12
; CHECK-NEXT: swpb r12
; CHECK-NEXT: rlam #4, r12
; CHECK-NEXT: rlam #2, r12
  %result = shl i16 %value, 14
  ret i16 %result
}

define i16 @shl15(i16 %value) {
; CHECK-LABEL: shl15:
; CHECK: mov.b r12, r12
; CHECK-NEXT: swpb r12
; CHECK-NEXT: rlam #4, r12
; CHECK-NEXT: rlam #3, r12
  %result = shl i16 %value, 15
  ret i16 %result
}

define i16 @shl16(i16 %value) {
; CHECK-LABEL: shl16:
; CHECK-NOT: rlam
; CHECK-NOT: rlax
  %result = shl i16 %value, 16
  ret i16 %result
}

;; Begin tests for shifts, when optimizing for size.
;;--------------------------------------------------
;; Tests for logical right shifts, when optimizing for size.
define i16 @lshr1_s(i16 %value) optsize {
; CHECK-LABEL: lshr1_s:
; CHECK: rrum #1, r12
  %result = lshr i16 %value, 1
  ret i16 %result
}

define i16 @lshr2_s(i16 %value) optsize {
; CHECK-LABEL: lshr2_s:
; CHECK: rrum #2, r12
  %result = lshr i16 %value, 2
  ret i16 %result
}

define i16 @lshr3_s(i16 %value) optsize {
; CHECK-LABEL: lshr3_s:
; CHECK: rrum #3, r12
  %result = lshr i16 %value, 3
  ret i16 %result
}

define i16 @lshr4_s(i16 %value) optsize {
; CHECK-LABEL: lshr4_s:
; CHECK: rrum #4, r12
  %result = lshr i16 %value, 4
  ret i16 %result
}

define i16 @lshr5_s(i16 %value) optsize {
; CHECK-LABEL: lshr5_s:
; CHECK: rrum #4, r12
; CHECK-NEXT: rrum #1, r12
  %result = lshr i16 %value, 5
  ret i16 %result
}

define i16 @lshr6_s(i16 %value) optsize {
; CHECK-LABEL: lshr6_s:
; CHECK: rrum #4, r12
; CHECK-NEXT: rrum #2, r12
  %result = lshr i16 %value, 6
  ret i16 %result
}

define i16 @lshr7_s(i16 %value) optsize {
; CHECK-LABEL: lshr7_s:
; CHECK: rrum #4, r12
; CHECK-NEXT: rrum #3, r12
  %result = lshr i16 %value, 7
  ret i16 %result
}

define i16 @lshr8_s(i16 %value) optsize {
; CHECK-LABEL: lshr8_s:
; CHECK: swpb r12
; CHECK-NEXT: mov.b r12, r12
  %result = lshr i16 %value, 8
  ret i16 %result
}

define i16 @lshr9_s(i16 %value) optsize {
; CHECK-LABEL: lshr9_s:
; CHECK: rpt #9 { rrux r12
  %result = lshr i16 %value, 9
  ret i16 %result
}

define i16 @lshr10_s(i16 %value) optsize {
; CHECK-LABEL: lshr10_s:
; CHECK: rpt #10 { rrux r12
  %result = lshr i16 %value, 10
  ret i16 %result
}

define i16 @lshr11_s(i16 %value) optsize {
; CHECK-LABEL: lshr11_s:
; CHECK: rpt #11 { rrux r12
  %result = lshr i16 %value, 11
  ret i16 %result
}

define i16 @lshr12_s(i16 %value) optsize {
; CHECK-LABEL: lshr12_s:
; CHECK: rpt #12 { rrux r12
  %result = lshr i16 %value, 12
  ret i16 %result
}

define i16 @lshr13_s(i16 %value) optsize {
; CHECK-LABEL: lshr13_s:
; CHECK: rpt #13 { rrux r12
  %result = lshr i16 %value, 13
  ret i16 %result
}

define i16 @lshr14_s(i16 %value) optsize {
; CHECK-LABEL: lshr14_s:
; CHECK: rpt #14 { rrux r12
  %result = lshr i16 %value, 14
  ret i16 %result
}

define i16 @lshr15_s(i16 %value) optsize {
; CHECK-LABEL: lshr15_s:
; CHECK: rpt #15 { rrux r12
  %result = lshr i16 %value, 15
  ret i16 %result
}

define i16 @lshr16_s(i16 %value) optsize {
; CHECK-LABEL: lshr16_s:
; CHECK-NOT: rrum
; CHECK-NOT: rrux
  %result = lshr i16 %value, 16
  ret i16 %result
}

;; Tests for arithmetic right shifts, when optimizing for size.
define i16 @ashr1_s(i16 %value) optsize {
; CHECK-LABEL: ashr1_s:
; CHECK: rra r12
  %result = ashr i16 %value, 1
  ret i16 %result
}

define i16 @ashr2_s(i16 %value) optsize {
; CHECK-LABEL: ashr2_s:
; CHECK: rram #2, r12
  %result = ashr i16 %value, 2
  ret i16 %result
}

define i16 @ashr3_s(i16 %value) optsize {
; CHECK-LABEL: ashr3_s:
; CHECK: rram #3, r12
  %result = ashr i16 %value, 3
  ret i16 %result
}

define i16 @ashr4_s(i16 %value) optsize {
; CHECK-LABEL: ashr4_s:
; CHECK: rram #4, r12
  %result = ashr i16 %value, 4
  ret i16 %result
}

define i16 @ashr5_s(i16 %value) optsize {
; CHECK-LABEL: ashr5_s:
; CHECK: rram #4, r12
; CHECK-NEXT: rram #1, r12
  %result = ashr i16 %value, 5
  ret i16 %result
}

define i16 @ashr6_s(i16 %value) optsize {
; CHECK-LABEL: ashr6_s:
; CHECK: rram #4, r12
; CHECK-NEXT: rram #2, r12
  %result = ashr i16 %value, 6
  ret i16 %result
}

define i16 @ashr7_s(i16 %value) optsize {
; CHECK-LABEL: ashr7_s:
; CHECK: rram #4, r12
; CHECK-NEXT: rram #3, r12
  %result = ashr i16 %value, 7
  ret i16 %result
}

define i16 @ashr8_s(i16 %value) optsize {
; CHECK-LABEL: ashr8_s:
; CHECK: swpb r12
; CHECK-NEXT: sxt r12
  %result = ashr i16 %value, 8
  ret i16 %result
}

define i16 @ashr9_s(i16 %value) optsize {
; CHECK-LABEL: ashr9_s:
; CHECK: rpt #9 { rrax r12
  %result = ashr i16 %value, 9
  ret i16 %result
}

define i16 @ashr10_s(i16 %value) optsize {
; CHECK-LABEL: ashr10_s:
; CHECK: rpt #10 { rrax r12
  %result = ashr i16 %value, 10
  ret i16 %result
}

define i16 @ashr11_s(i16 %value) optsize {
; CHECK-LABEL: ashr11_s:
; CHECK: rpt #11 { rrax r12
  %result = ashr i16 %value, 11
  ret i16 %result
}

define i16 @ashr12_s(i16 %value) optsize {
; CHECK-LABEL: ashr12_s:
; CHECK: rpt #12 { rrax r12
  %result = ashr i16 %value, 12
  ret i16 %result
}

define i16 @ashr13_s(i16 %value) optsize {
; CHECK-LABEL: ashr13_s:
; CHECK: rpt #13 { rrax r12
  %result = ashr i16 %value, 13
  ret i16 %result
}

define i16 @ashr14_s(i16 %value) optsize {
; CHECK-LABEL: ashr14_s:
; CHECK: rpt #14 { rrax r12
  %result = ashr i16 %value, 14
  ret i16 %result
}

define i16 @ashr15_s(i16 %value) optsize {
; CHECK-LABEL: ashr15_s:
; CHECK: rpt #15 { rrax r12
  %result = ashr i16 %value, 15
  ret i16 %result
}

define i16 @ashr16_s(i16 %value) optsize {
; CHECK-LABEL: ashr16_s:
; CHECK-NOT: rram
; CHECK-NOT: rrax
  %result = ashr i16 %value, 16
  ret i16 %result
}

;; Tests for logical left shifts, when optimizing for size.
define i16 @shl1_s(i16 %value) optsize {
; CHECK-LABEL: shl1_s:
; CHECK: add r12, r12
  %result = shl i16 %value, 1
  ret i16 %result
}

define i16 @shl2_s(i16 %value) optsize {
; CHECK-LABEL: shl2_s:
; CHECK: rlam #2, r12
  %result = shl i16 %value, 2
  ret i16 %result
}

define i16 @shl3_s(i16 %value) optsize {
; CHECK-LABEL: shl3_s:
; CHECK: rlam #3, r12
  %result = shl i16 %value, 3
  ret i16 %result
}

define i16 @shl4_s(i16 %value) optsize {
; CHECK-LABEL: shl4_s:
; CHECK: rlam #4, r12
  %result = shl i16 %value, 4
  ret i16 %result
}

define i16 @shl5_s(i16 %value) optsize {
; CHECK-LABEL: shl5_s:
; CHECK: rlam #4, r12
; CHECK-NEXT: rlam #1, r12
  %result = shl i16 %value, 5
  ret i16 %result
}

define i16 @shl6_s(i16 %value) optsize {
; CHECK-LABEL: shl6_s:
; CHECK: rlam #4, r12
; CHECK-NEXT: rlam #2, r12
  %result = shl i16 %value, 6
  ret i16 %result
}

define i16 @shl7_s(i16 %value) optsize {
; CHECK-LABEL: shl7_s:
; CHECK: rlam #4, r12
; CHECK-NEXT: rlam #3, r12
  %result = shl i16 %value, 7
  ret i16 %result
}

define i16 @shl8_s(i16 %value) optsize {
; CHECK-LABEL: shl8_s:
; CHECK: mov.b r12, r12
; CHECK-NEXT: swpb r12
  %result = shl i16 %value, 8
  ret i16 %result
}

define i16 @shl9_s(i16 %value) optsize {
; CHECK-LABEL: shl9_s:
; CHECK: rpt #9 { rlax r12
  %result = shl i16 %value, 9
  ret i16 %result
}

define i16 @shl10_s(i16 %value) optsize {
; CHECK-LABEL: shl10_s:
; CHECK: rpt #10 { rlax r12
  %result = shl i16 %value, 10
  ret i16 %result
}

define i16 @shl11_s(i16 %value) optsize {
; CHECK-LABEL: shl11_s:
; CHECK: rpt #11 { rlax r12
  %result = shl i16 %value, 11
  ret i16 %result
}

define i16 @shl12_s(i16 %value) optsize {
; CHECK-LABEL: shl12_s:
; CHECK: rpt #12 { rlax r12
  %result = shl i16 %value, 12
  ret i16 %result
}

define i16 @shl13_s(i16 %value) optsize {
; CHECK-LABEL: shl13_s:
; CHECK: rpt #13 { rlax r12
  %result = shl i16 %value, 13
  ret i16 %result
}

define i16 @shl14_s(i16 %value) optsize {
; CHECK-LABEL: shl14_s:
; CHECK: rpt #14 { rlax r12
  %result = shl i16 %value, 14
  ret i16 %result
}

define i16 @shl15_s(i16 %value) optsize {
; CHECK-LABEL: shl15_s:
; CHECK: rpt #15 { rlax r12
  %result = shl i16 %value, 15
  ret i16 %result
}

define i16 @shl16_s(i16 %value) optsize {
; CHECK-LABEL: shl16_s:
; CHECK-NOT: rlam
; CHECK-NOT: rlax
  %result = shl i16 %value, 16
  ret i16 %result
}

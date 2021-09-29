; Tests for constant shifts of 8-bit register operands, for the 430X CPU.
;
; RUN: llc -mcpu=msp430x < %s | FileCheck %s
target datalayout = "e-p:16:8:8-i8:8:8-i8:8:8-i32:8:8-n8:16"
target triple = "msp430-elf"

;; Tests for logical right shifts.
define i8 @lshr1(i8 %value) {
; CHECK-LABEL: lshr1:
; CHECK: clrc
; CHECK-NEXT: rrc.b r12
  %result = lshr i8 %value, 1
  ret i8 %result
}

define i8 @lshr2(i8 %value) {
; CHECK-LABEL: lshr2:
; CHECK: rpt #2 { rrux.b r12
  %result = lshr i8 %value, 2
  ret i8 %result
}

define i8 @lshr3(i8 %value) {
; CHECK-LABEL: lshr3:
; CHECK: rpt #3 { rrux.b r12
  %result = lshr i8 %value, 3
  ret i8 %result
}

define i8 @lshr4(i8 %value) {
; CHECK-LABEL: lshr4:
; CHECK: rpt #4 { rrux.b r12
  %result = lshr i8 %value, 4
  ret i8 %result
}

define i8 @lshr5(i8 %value) {
; CHECK-LABEL: lshr5:
; CHECK: rpt #5 { rrux.b r12
  %result = lshr i8 %value, 5
  ret i8 %result
}

define i8 @lshr6(i8 %value) {
; CHECK-LABEL: lshr6:
; CHECK: rpt #6 { rrux.b r12
  %result = lshr i8 %value, 6
  ret i8 %result
}

define i8 @lshr7(i8 %value) {
; CHECK-LABEL: lshr7:
; CHECK: rpt #7 { rrux.b r12
  %result = lshr i8 %value, 7
  ret i8 %result
}

define i8 @lshr8(i8 %value) {
; CHECK-LABEL: lshr8:
; CHECK-NOT: rrum
; CHECK-NOT: rrux
  %result = lshr i8 %value, 8
  ret i8 %result
}

;; Tests for arithmetic right shifts.
define i8 @ashr1(i8 %value) {
; CHECK-LABEL: ashr1:
; CHECK: rra.b r12
  %result = ashr i8 %value, 1
  ret i8 %result
}

define i8 @ashr2(i8 %value) {
; CHECK-LABEL: ashr2:
; CHECK: rpt #2 { rrax.b r12
  %result = ashr i8 %value, 2
  ret i8 %result
}

define i8 @ashr3(i8 %value) {
; CHECK-LABEL: ashr3:
; CHECK: rpt #3 { rrax.b r12
  %result = ashr i8 %value, 3
  ret i8 %result
}

define i8 @ashr4(i8 %value) {
; CHECK-LABEL: ashr4:
; CHECK: rpt #4 { rrax.b r12
  %result = ashr i8 %value, 4
  ret i8 %result
}

define i8 @ashr5(i8 %value) {
; CHECK-LABEL: ashr5:
; CHECK: rpt #5 { rrax.b r12
  %result = ashr i8 %value, 5
  ret i8 %result
}

define i8 @ashr6(i8 %value) {
; CHECK-LABEL: ashr6:
; CHECK: rpt #6 { rrax.b r12
  %result = ashr i8 %value, 6
  ret i8 %result
}

define i8 @ashr7(i8 %value) {
; CHECK-LABEL: ashr7:
; CHECK: rpt #7 { rrax.b r12
  %result = ashr i8 %value, 7
  ret i8 %result
}

define i8 @ashr8(i8 %value) {
; CHECK-LABEL: ashr8:
; CHECK-NOT: rra
  %result = ashr i8 %value, 8
  ret i8 %result
}

;; Tests for logical left shifts.
define i8 @shl1(i8 %value) {
; CHECK-LABEL: shl1:
; CHECK: add.b r12, r12
  %result = shl i8 %value, 1
  ret i8 %result
}

define i8 @shl2(i8 %value) {
; CHECK-LABEL: shl2:
; CHECK: rpt #2 { rlax.b r12
  %result = shl i8 %value, 2
  ret i8 %result
}

define i8 @shl3(i8 %value) {
; CHECK-LABEL: shl3:
; CHECK: rpt #3 { rlax.b r12
  %result = shl i8 %value, 3
  ret i8 %result
}

define i8 @shl4(i8 %value) {
; CHECK-LABEL: shl4:
; CHECK: rpt #4 { rlax.b r12
  %result = shl i8 %value, 4
  ret i8 %result
}

define i8 @shl5(i8 %value) {
; CHECK-LABEL: shl5:
; CHECK: rpt #5 { rlax.b r12
  %result = shl i8 %value, 5
  ret i8 %result
}

define i8 @shl6(i8 %value) {
; CHECK-LABEL: shl6:
; CHECK: rpt #6 { rlax.b r12
  %result = shl i8 %value, 6
  ret i8 %result
}

define i8 @shl7(i8 %value) {
; CHECK-LABEL: shl7:
; CHECK: rpt #7 { rlax.b r12
  %result = shl i8 %value, 7
  ret i8 %result
}

define i8 @shl8(i8 %value) {
; CHECK-LABEL: shl8:
; CHECK-NOT: rla
  %result = shl i8 %value, 8
  ret i8 %result
}

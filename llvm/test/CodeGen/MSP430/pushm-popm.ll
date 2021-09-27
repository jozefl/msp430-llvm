; Tests for the use of PUSHM/POPM in function prologue/epilogues, for
; the MSP430X CPU.
;
; RUN: llc -mcpu=msp430x < %s | FileCheck %s
target datalayout = "e-m:e-p:16:16-i32:16-i64:16-f32:16-f64:16-a:8-n8:16-S16"
target triple = "msp430"

define dso_local void @r4c1() {
entry:
; CHECK-LABEL: r4c1:
; CHECK: pushm #1, r4
; CHECK: popm #1, r4
  call void asm sideeffect ";blah", "~{r4}"()
  ret void
}

define dso_local void @r5c2() {
entry:
; CHECK-LABEL: r5c2:
; CHECK: pushm #2, r5
; CHECK: popm #2, r5
  call void asm sideeffect ";blah", "~{r4},~{r5}"()
  ret void
}

define dso_local void @r6c3() {
entry:
; CHECK-LABEL: r6c3:
; CHECK: pushm #3, r6
; CHECK: popm #3, r6
  call void asm sideeffect ";blah", "~{r4},~{r5},~{r6}"()
  ret void
}

define dso_local void @r7c4() {
entry:
; CHECK-LABEL: r7c4:
; CHECK: pushm #4, r7
; CHECK: popm #4, r7
  call void asm sideeffect ";blah", "~{r4},~{r5},~{r6},~{r7}"()
  ret void
}

define dso_local void @r8c5() {
entry:
; CHECK-LABEL: r8c5:
; CHECK: pushm #5, r8
; CHECK: popm #5, r8
  call void asm sideeffect ";blah", "~{r4},~{r5},~{r6},~{r7},~{r8}"()
  ret void
}

define dso_local void @r9c6() {
entry:
; CHECK-LABEL: r9c6:
; CHECK: pushm #6, r9
; CHECK: popm #6, r9
  call void asm sideeffect ";blah", "~{r4},~{r5},~{r6},~{r7},~{r8},~{r9}"()
  ret void
}

define dso_local void @r10c7() {
entry:
; CHECK-LABEL: r10c7:
; CHECK: pushm #7, r10
; CHECK: popm #7, r10
  call void asm sideeffect ";blah", "~{r4},~{r5},~{r6},~{r7},~{r8},~{r9},~{r10}"()
  ret void
}

; r11 is caller-saved so should not be spilled in the prologue.
define dso_local void @r11c8() {
entry:
; CHECK-LABEL: r11c8:
; CHECK: pushm #7, r10
; CHECK: popm #7, r10
  call void asm sideeffect ";blah", "~{r4},~{r5},~{r6},~{r7},~{r8},~{r9},~{r10},~{r11}"()
  ret void
}

; Test that saving/restoring the frame pointer in function prologues and
; epilogues does not affect saving/restoring callee-saved registers, or the
; stack pointer adjustment required by the function itself.
;
; RUN: llc -mcpu=msp430 < %s | FileCheck %s --check-prefixes=MSP430,BOTH
; RUN: llc -mcpu=msp430x < %s | FileCheck %s --check-prefixes=MSP430X,BOTH

target datalayout = "e-m:e-p:16:16-i32:16-i64:16-f32:16-f64:16-a:8-n8:16-S16"
target triple = "msp430"

define dso_local double @foo(double %a, double %b, double %c, double %d) local_unnamed_addr #0 {
entry:
; CHECK-LABEL: foo:
; BOTH: push	r4
; BOTH-NEXT: mov	r1, r4

; MSP430: push	r10
; MSP430-NEXT: push	r9
; MSP430-NEXT: push	r8
; MSP430-NEXT: push	r7
; MSP430-NEXT: push	r6
; MSP430-NEXT: push	r5
; MSP430X: pushm #6, r10

; BOTH: sub	#{{[0-9]+}}, r1

  call void asm sideeffect ";blah", "~{r5},~{r6},~{r7},~{r8},~{r9},~{r10}"()
  %call = call i16 @boo(double %b, double %c, double %d, double %a) #0
  %0 = alloca i8, i16 %call, align 2
  %call1 = call double @bar(double %a, double %b, double %c, double %d, i8* nonnull %0) #0
  %1 = alloca i8, i16 %call, align 2
  %call2 = call double @bar(double %d, double %c, double %b, double %a, i8* nonnull %1) #0
  %add = fadd double %call1, %call2
  ret double %add

; BOTH: mov	r4, r1
; BOTH-NEXT: sub	#{{[0-9]+}}, r1
;
; MSP430: pop	r5
; MSP430: pop	r6
; MSP430: pop	r7
; MSP430: pop	r8
; MSP430: pop	r9
; MSP430: pop	r10
; MSP430X: popm #6, r10
;
; BOTH: pop	r4
; BOTH-NEXT: ret
}

declare dso_local i16 @boo(double, double, double, double) local_unnamed_addr #1
declare dso_local double @bar(double, double, double, double, i8*) local_unnamed_addr #1

attributes #0 = { nounwind "frame-pointer"="all" }

!llvm.module.flags = !{!0}
!0 = !{i32 7, !"frame-pointer", i32 2}

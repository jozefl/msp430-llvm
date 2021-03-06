; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s --check-prefix=CHECK

define i32 @fold_urem_positive_odd(i32 %x) {
; CHECK-LABEL: fold_urem_positive_odd:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    movl %edi, %ecx
; CHECK-NEXT:    imulq $1491936009, %rcx, %rcx # imm = 0x58ED2309
; CHECK-NEXT:    shrq $32, %rcx
; CHECK-NEXT:    movl %edi, %edx
; CHECK-NEXT:    subl %ecx, %edx
; CHECK-NEXT:    shrl %edx
; CHECK-NEXT:    addl %ecx, %edx
; CHECK-NEXT:    shrl $6, %edx
; CHECK-NEXT:    imull $95, %edx, %ecx
; CHECK-NEXT:    subl %ecx, %eax
; CHECK-NEXT:    retq
  %1 = urem i32 %x, 95
  ret i32 %1
}


define i32 @fold_urem_positive_even(i32 %x) {
; CHECK-LABEL: fold_urem_positive_even:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    movl %edi, %ecx
; CHECK-NEXT:    movl $4149100483, %edx # imm = 0xF74E3FC3
; CHECK-NEXT:    imulq %rcx, %rdx
; CHECK-NEXT:    shrq $42, %rdx
; CHECK-NEXT:    imull $1060, %edx, %ecx # imm = 0x424
; CHECK-NEXT:    subl %ecx, %eax
; CHECK-NEXT:    retq
  %1 = urem i32 %x, 1060
  ret i32 %1
}


; Don't fold if we can combine urem with udiv.
define i32 @combine_urem_udiv(i32 %x) {
; CHECK-LABEL: combine_urem_udiv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    imulq $1491936009, %rax, %rcx # imm = 0x58ED2309
; CHECK-NEXT:    shrq $32, %rcx
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    subl %ecx, %eax
; CHECK-NEXT:    shrl %eax
; CHECK-NEXT:    addl %ecx, %eax
; CHECK-NEXT:    shrl $6, %eax
; CHECK-NEXT:    imull $95, %eax, %ecx
; CHECK-NEXT:    subl %ecx, %edi
; CHECK-NEXT:    addl %edi, %eax
; CHECK-NEXT:    retq
  %1 = urem i32 %x, 95
  %2 = udiv i32 %x, 95
  %3 = add i32 %1, %2
  ret i32 %3
}

; Don't fold for divisors that are a power of two.
define i32 @dont_fold_urem_power_of_two(i32 %x) {
; CHECK-LABEL: dont_fold_urem_power_of_two:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    andl $63, %eax
; CHECK-NEXT:    retq
  %1 = urem i32 %x, 64
  ret i32 %1
}

; Don't fold if the divisor is one.
define i32 @dont_fold_urem_one(i32 %x) {
; CHECK-LABEL: dont_fold_urem_one:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    retq
  %1 = urem i32 %x, 1
  ret i32 %1
}

; Don't fold if the divisor is 2^32.
define i32 @dont_fold_urem_i32_umax(i32 %x) {
; CHECK-LABEL: dont_fold_urem_i32_umax:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %1 = urem i32 %x, 4294967296
  ret i32 %1
}

; Don't fold i64 urem
define i64 @dont_fold_urem_i64(i64 %x) {
; CHECK-LABEL: dont_fold_urem_i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    shrq %rax
; CHECK-NEXT:    movabsq $6023426636313322977, %rcx # imm = 0x5397829CBC14E5E1
; CHECK-NEXT:    mulq %rcx
; CHECK-NEXT:    shrq $4, %rdx
; CHECK-NEXT:    imulq $98, %rdx, %rax
; CHECK-NEXT:    subq %rax, %rdi
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    retq
  %1 = urem i64 %x, 98
  ret i64 %1
}

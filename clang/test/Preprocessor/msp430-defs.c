// Check the correct macros are defined for each CPU.

// RUN: %clang -target msp430 -x c -E -dM %s -o - | FileCheck  %s
// RUN: %clang -target msp430 -mcpu=generic -x c -E -dM %s -o - | FileCheck %s
// RUN: %clang -target msp430 -mcpu=msp430 -x c -E -dM %s -o - | FileCheck %s

// CHECK: MSP430
// CHECK: __ELF__
// CHECK-NOT: __MSP430X__
// CHECK: __MSP430__

// RUN: %clang -target msp430 -mcpu=msp430x -x c -E -dM %s -o - \
// RUN:   | FileCheck --check-prefix=MSP430X %s
// RUN: %clang -target msp430 -mcpu=msp430xv2 -x c -E -dM %s -o - \
// RUN:   | FileCheck --check-prefix=MSP430X %s

// MSP430X: MSP430
// MSP430X: __ELF__
// MSP430X: __MSP430X__
// MSP430X: __MSP430__

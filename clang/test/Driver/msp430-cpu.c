// Check the correct translation of -mcpu= to -target-cpu.

// RUN: %clang -target msp430 -mcpu=generic -### -c %s 2>&1 | FileCheck -check-prefix=GENERIC %s
// GENERIC: "-cc1"{{.*}} "-target-cpu" "generic"

// RUN: %clang -target msp430 -### -c %s 2>&1 | FileCheck -check-prefix=MSP430 %s
// RUN: %clang -target msp430 -mcpu=msp430 -### -c %s 2>&1 | FileCheck -check-prefix=MSP430 %s
// MSP430: "-cc1"{{.*}} "-target-cpu" "msp430"

// RUN: %clang -target msp430 -mcpu=msp430x -### -c %s 2>&1 | FileCheck -check-prefix=MSP430X %s
// MSP430X: "-cc1"{{.*}} "-target-cpu" "msp430x"

// RUN: %clang -target msp430 -mcpu=msp430xv2 -### -c %s 2>&1 | FileCheck -check-prefix=MSP430XV2 %s
// MSP430XV2: "-cc1"{{.*}} "-target-cpu" "msp430xv2"

// Test that Clang emits an error on an invalid value passed to -mcpu=.
// RUN: not %clang  -target msp430 -mcpu=msp430xv3 -v -c %s 2>&1 | FileCheck -check-prefix=MSP430XV3 %s
// MSP430XV3: error: unknown target CPU 'msp430xv3'
// MSP430XV3-NEXT: note: valid target CPU values are: generic, msp430, msp430x, msp430xv2

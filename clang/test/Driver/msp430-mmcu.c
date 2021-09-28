// This file tests that various different values passed to -mmcu= select the
// correct target features and linker scripts, and create MCU-specific defines.

// Test the lexicographic ordering of MCUs in MSP430Target.def.
//
// The MCU "msp430f110" should appear before "msp430f1101" when the data has
// been sorted lexicographically. Some sorts will put "msp430f110" *after*
// "msp430f1101", so when this happens, Clang will not be able to find this MCU.

// RUN: %clang %s -### -no-canonical-prefixes -target msp430 -mmcu=msp430f110 2>&1 \
// RUN:   | FileCheck %s

// RUN: %clang %s -### -no-canonical-prefixes -target msp430 -mmcu=msp430f1101 2>&1 \
// RUN:   | FileCheck %s

// RUN: %clang %s -### -no-canonical-prefixes -target msp430 -mmcu=msp430f1101a 2>&1 \
// RUN:   | FileCheck %s

// CHECK-NOT: error: the clang compiler does not support

// Test the symbol definitions, linker scripts and hardware multiply features
// selected for different MCUs.

// RUN: %clang %s -### -no-canonical-prefixes -target msp430 -mmcu=msp430c111 2>&1 \
// RUN:   | FileCheck -check-prefix=MSP430-C111 %s

// MSP430-C111: clang{{.*}} "-cc1" {{.*}} "-D__MSP430C111__"
// MSP430-C111-NOT: "-target-feature" "+hwmult16"
// MSP430-C111-NOT: "-target-feature" "+hwmult32"
// MSP430-C111-NOT: "-target-feature" "+hwmultf5"
// MSP430-C111: msp430-elf-ld{{.*}} "-Tmsp430c111.ld"

// RUN: %clang %s -### -no-canonical-prefixes -target msp430 -mmcu=msp430i2020 2>&1 \
// RUN:   | FileCheck -check-prefix=MSP430-I2020 %s

// MSP430-I2020: clang{{.*}} "-cc1" {{.*}} "-D__MSP430i2020__"
// MSP430-I2020: "-target-feature" "+hwmult16"
// MSP430-I2020: msp430-elf-ld{{.*}} "-Tmsp430i2020.ld"

// RUN: %clang %s -### -no-canonical-prefixes -target msp430 -mmcu=msp430f47126 2>&1 \
// RUN:   | FileCheck -check-prefix=MSP430-F47126 %s

// MSP430-F47126: clang{{.*}} "-cc1" {{.*}} "-D__MSP430F47126__"
// MSP430-F47126: "-target-feature" "+hwmult32"
// MSP430-F47126: msp430-elf-ld{{.*}} "-Tmsp430f47126.ld"

// RAN: %clang %s -### -no-canonical-prefixes -target msp430 -mmcu=msp430fr5969 2>&1 \
// RAN:   | FileCheck -check-prefix=MSP430-FR5969 %s

// MSP430-FR5969: clang{{.*}} "-cc1" {{.*}} "-D__MSP430FR5969__"
// MSP430-FR5969: "-target-feature" "+hwmultf5"
// MSP430-FR5969: msp430-elf-ld{{.*}} "-Tmsp430fr5969.ld"

// Test for the error message emitted when an invalid MCU is selected.
//
// Note that if this test is ever modified because the expected error message is
// changed, the check prefixes at the top of this file, used to validate the
// ordering of the hard-coded MCU data, also need to be updated.
//
// RUN: %clang %s -### -no-canonical-prefixes -target msp430 -mmcu=not-a-mcu 2>&1 \
// RUN:   | FileCheck -check-prefix=MSP430-UNSUP %s

// MSP430-UNSUP: error: the clang compiler does not support 'not-a-mcu'

// The generic MCU name "msp430" is not supported.
// RUN: %clang %s -### -no-canonical-prefixes -target msp430 -mmcu=msp430 2>&1 \
// RUN:   | FileCheck -check-prefix=MSP430 %s

// MSP430: error: the clang compiler does not support 'msp430'

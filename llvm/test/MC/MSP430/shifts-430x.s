// Test the encoding of shift instructions for the 430X CPU.

// RUN: llvm-mc -triple msp430 -mcpu=msp430x -show-encoding < %s | FileCheck %s
rxxm:
	rrum	#1, r12                         ; encoding: [0x5c,0x03]
	rrum	#2, r12                         ; encoding: [0x5c,0x07]
	rrum	#3, r12                         ; encoding: [0x5c,0x0b]
	rrum	#4, r12                         ; encoding: [0x5c,0x0f]

	rram	#1, r12                         ; encoding: [0x5c,0x01]
	rram	#2, r12                         ; encoding: [0x5c,0x05]
	rram	#3, r12                         ; encoding: [0x5c,0x09]
	rram	#4, r12                         ; encoding: [0x5c,0x0d]

	rlam	#1, r12                         ; encoding: [0x5c,0x02]
	rlam	#2, r12                         ; encoding: [0x5c,0x06]
	rlam	#3, r12                         ; encoding: [0x5c,0x0a]
	rlam	#4, r12                         ; encoding: [0x5c,0x0e]

// CHECK-LABEL: rxxm:
// CHECK-NEXT: rrum	#1, r12                         ; encoding: [0x5c,0x03]
// CHECK: rrum	#2, r12                         ; encoding: [0x5c,0x07]
// CHECK: rrum	#3, r12                         ; encoding: [0x5c,0x0b]
// CHECK: rrum	#4, r12                         ; encoding: [0x5c,0x0f]

// CHECK: rram	#1, r12                         ; encoding: [0x5c,0x01]
// CHECK: rram	#2, r12                         ; encoding: [0x5c,0x05]
// CHECK: rram	#3, r12                         ; encoding: [0x5c,0x09]
// CHECK: rram	#4, r12                         ; encoding: [0x5c,0x0d]

// CHECK: rlam	#1, r12                         ; encoding: [0x5c,0x02]
// CHECK: rlam	#2, r12                         ; encoding: [0x5c,0x06]
// CHECK: rlam	#3, r12                         ; encoding: [0x5c,0x0a]
// CHECK: rlam	#4, r12                         ; encoding: [0x5c,0x0e]

rrux:
  rrux r12
  rpt #1 { rrux r12
  rpt #2 { rrux r12
  rpt #3 { rrux r12
  rpt #4 { rrux r12
  rpt #5 { rrux r12
  rpt #6 { rrux r12
  rpt #7 { rrux r12
  rpt #8 { rrux r12
  rpt #9 { rrux r12
  rpt #10 { rrux r12
  rpt #11 { rrux r12
  rpt #12 { rrux r12
  rpt #13 { rrux r12
  rpt #14 { rrux r12
  rpt #15 { rrux r12
  rpt #16 { rrux r12

// CHECK-LABEL: rrux:
// CHECK-NEXT: rrux	r12                             ; encoding: [0x40,0x19,0x0c,0x10]
// CHECK: rrux	r12                             ; encoding: [0x40,0x19,0x0c,0x10]
// CHECK: rpt	#2	{	rrux	r12     ; encoding: [0x41,0x19,0x0c,0x10]
// CHECK: rpt	#3	{	rrux	r12     ; encoding: [0x42,0x19,0x0c,0x10]
// CHECK: rpt	#4	{	rrux	r12     ; encoding: [0x43,0x19,0x0c,0x10]
// CHECK: rpt	#5	{	rrux	r12     ; encoding: [0x44,0x19,0x0c,0x10]
// CHECK: rpt	#6	{	rrux	r12     ; encoding: [0x45,0x19,0x0c,0x10]
// CHECK: rpt	#7	{	rrux	r12     ; encoding: [0x46,0x19,0x0c,0x10]
// CHECK: rpt	#8	{	rrux	r12     ; encoding: [0x47,0x19,0x0c,0x10]
// CHECK: rpt	#9	{	rrux	r12     ; encoding: [0x48,0x19,0x0c,0x10]
// CHECK: rpt	#10	{	rrux	r12     ; encoding: [0x49,0x19,0x0c,0x10]
// CHECK: rpt	#11	{	rrux	r12     ; encoding: [0x4a,0x19,0x0c,0x10]
// CHECK: rpt	#12	{	rrux	r12     ; encoding: [0x4b,0x19,0x0c,0x10]
// CHECK: rpt	#13	{	rrux	r12     ; encoding: [0x4c,0x19,0x0c,0x10]
// CHECK: rpt	#14	{	rrux	r12     ; encoding: [0x4d,0x19,0x0c,0x10]
// CHECK: rpt	#15	{	rrux	r12     ; encoding: [0x4e,0x19,0x0c,0x10]
// CHECK: rpt	#16	{	rrux	r12     ; encoding: [0x4f,0x19,0x0c,0x10]

rrux_b:
  rrux.b r12
  rpt #1 { rrux.b r12
  rpt #2 { rrux.b r12
  rpt #3 { rrux.b r12
  rpt #4 { rrux.b r12
  rpt #5 { rrux.b r12
  rpt #6 { rrux.b r12
  rpt #7 { rrux.b r12
  rpt #8 { rrux.b r12
  rpt #9 { rrux.b r12
  rpt #10 { rrux.b r12
  rpt #11 { rrux.b r12
  rpt #12 { rrux.b r12
  rpt #13 { rrux.b r12
  rpt #14 { rrux.b r12
  rpt #15 { rrux.b r12
  rpt #16 { rrux.b r12

// CHECK-LABEL: rrux_b:
// CHECK-NEXT: rrux.b	r12                             ; encoding: [0x40,0x19,0x4c,0x10]
// CHECK: rrux.b	r12                             ; encoding: [0x40,0x19,0x4c,0x10]
// CHECK: rpt	#2	{	rrux.b	r12     ; encoding: [0x41,0x19,0x4c,0x10]
// CHECK: rpt	#3	{	rrux.b	r12     ; encoding: [0x42,0x19,0x4c,0x10]
// CHECK: rpt	#4	{	rrux.b	r12     ; encoding: [0x43,0x19,0x4c,0x10]
// CHECK: rpt	#5	{	rrux.b	r12     ; encoding: [0x44,0x19,0x4c,0x10]
// CHECK: rpt	#6	{	rrux.b	r12     ; encoding: [0x45,0x19,0x4c,0x10]
// CHECK: rpt	#7	{	rrux.b	r12     ; encoding: [0x46,0x19,0x4c,0x10]
// CHECK: rpt	#8	{	rrux.b	r12     ; encoding: [0x47,0x19,0x4c,0x10]
// CHECK: rpt	#9	{	rrux.b	r12     ; encoding: [0x48,0x19,0x4c,0x10]
// CHECK: rpt	#10	{	rrux.b	r12     ; encoding: [0x49,0x19,0x4c,0x10]
// CHECK: rpt	#11	{	rrux.b	r12     ; encoding: [0x4a,0x19,0x4c,0x10]
// CHECK: rpt	#12	{	rrux.b	r12     ; encoding: [0x4b,0x19,0x4c,0x10]
// CHECK: rpt	#13	{	rrux.b	r12     ; encoding: [0x4c,0x19,0x4c,0x10]
// CHECK: rpt	#14	{	rrux.b	r12     ; encoding: [0x4d,0x19,0x4c,0x10]
// CHECK: rpt	#15	{	rrux.b	r12     ; encoding: [0x4e,0x19,0x4c,0x10]
// CHECK: rpt	#16	{	rrux.b	r12     ; encoding: [0x4f,0x19,0x4c,0x10]

rrax:
  rrax r12
  rpt #1 { rrax r12
  rpt #2 { rrax r12
  rpt #3 { rrax r12
  rpt #4 { rrax r12
  rpt #5 { rrax r12
  rpt #6 { rrax r12
  rpt #7 { rrax r12
  rpt #8 { rrax r12
  rpt #9 { rrax r12
  rpt #10 { rrax r12
  rpt #11 { rrax r12
  rpt #12 { rrax r12
  rpt #13 { rrax r12
  rpt #14 { rrax r12
  rpt #15 { rrax r12
  rpt #16 { rrax r12

// CHECK-LABEL: rrax:
// CHECK-NEXT: rrax	r12                             ; encoding: [0x40,0x18,0x0c,0x11]
// CHECK: rrax	r12                             ; encoding: [0x40,0x18,0x0c,0x11]
// CHECK: rpt	#2	{	rrax	r12     ; encoding: [0x41,0x18,0x0c,0x11]
// CHECK: rpt	#3	{	rrax	r12     ; encoding: [0x42,0x18,0x0c,0x11]
// CHECK: rpt	#4	{	rrax	r12     ; encoding: [0x43,0x18,0x0c,0x11]
// CHECK: rpt	#5	{	rrax	r12     ; encoding: [0x44,0x18,0x0c,0x11]
// CHECK: rpt	#6	{	rrax	r12     ; encoding: [0x45,0x18,0x0c,0x11]
// CHECK: rpt	#7	{	rrax	r12     ; encoding: [0x46,0x18,0x0c,0x11]
// CHECK: rpt	#8	{	rrax	r12     ; encoding: [0x47,0x18,0x0c,0x11]
// CHECK: rpt	#9	{	rrax	r12     ; encoding: [0x48,0x18,0x0c,0x11]
// CHECK: rpt	#10	{	rrax	r12     ; encoding: [0x49,0x18,0x0c,0x11]
// CHECK: rpt	#11	{	rrax	r12     ; encoding: [0x4a,0x18,0x0c,0x11]
// CHECK: rpt	#12	{	rrax	r12     ; encoding: [0x4b,0x18,0x0c,0x11]
// CHECK: rpt	#13	{	rrax	r12     ; encoding: [0x4c,0x18,0x0c,0x11]
// CHECK: rpt	#14	{	rrax	r12     ; encoding: [0x4d,0x18,0x0c,0x11]
// CHECK: rpt	#15	{	rrax	r12     ; encoding: [0x4e,0x18,0x0c,0x11]
// CHECK: rpt	#16	{	rrax	r12     ; encoding: [0x4f,0x18,0x0c,0x11]

rrax_b:
  rrax.b r12
  rpt #1 { rrax.b r12
  rpt #2 { rrax.b r12
  rpt #3 { rrax.b r12
  rpt #4 { rrax.b r12
  rpt #5 { rrax.b r12
  rpt #6 { rrax.b r12
  rpt #7 { rrax.b r12
  rpt #8 { rrax.b r12
  rpt #9 { rrax.b r12
  rpt #10 { rrax.b r12
  rpt #11 { rrax.b r12
  rpt #12 { rrax.b r12
  rpt #13 { rrax.b r12
  rpt #14 { rrax.b r12
  rpt #15 { rrax.b r12
  rpt #16 { rrax.b r12

// CHECK-LABEL: rrax_b:
// CHECK-NEXT: rrax.b	r12                             ; encoding: [0x40,0x18,0x4c,0x11]
// CHECK: rrax.b	r12                             ; encoding: [0x40,0x18,0x4c,0x11]
// CHECK: rpt	#2	{	rrax.b	r12     ; encoding: [0x41,0x18,0x4c,0x11]
// CHECK: rpt	#3	{	rrax.b	r12     ; encoding: [0x42,0x18,0x4c,0x11]
// CHECK: rpt	#4	{	rrax.b	r12     ; encoding: [0x43,0x18,0x4c,0x11]
// CHECK: rpt	#5	{	rrax.b	r12     ; encoding: [0x44,0x18,0x4c,0x11]
// CHECK: rpt	#6	{	rrax.b	r12     ; encoding: [0x45,0x18,0x4c,0x11]
// CHECK: rpt	#7	{	rrax.b	r12     ; encoding: [0x46,0x18,0x4c,0x11]
// CHECK: rpt	#8	{	rrax.b	r12     ; encoding: [0x47,0x18,0x4c,0x11]
// CHECK: rpt	#9	{	rrax.b	r12     ; encoding: [0x48,0x18,0x4c,0x11]
// CHECK: rpt	#10	{	rrax.b	r12     ; encoding: [0x49,0x18,0x4c,0x11]
// CHECK: rpt	#11	{	rrax.b	r12     ; encoding: [0x4a,0x18,0x4c,0x11]
// CHECK: rpt	#12	{	rrax.b	r12     ; encoding: [0x4b,0x18,0x4c,0x11]
// CHECK: rpt	#13	{	rrax.b	r12     ; encoding: [0x4c,0x18,0x4c,0x11]
// CHECK: rpt	#14	{	rrax.b	r12     ; encoding: [0x4d,0x18,0x4c,0x11]
// CHECK: rpt	#15	{	rrax.b	r12     ; encoding: [0x4e,0x18,0x4c,0x11]
// CHECK: rpt	#16	{	rrax.b	r12     ; encoding: [0x4f,0x18,0x4c,0x11]

rlax:
  rlax r12
  rpt #1 { rlax r12
  rpt #2 { rlax r12
  rpt #3 { rlax r12
  rpt #4 { rlax r12
  rpt #5 { rlax r12
  rpt #6 { rlax r12
  rpt #7 { rlax r12
  rpt #8 { rlax r12
  rpt #9 { rlax r12
  rpt #10 { rlax r12
  rpt #11 { rlax r12
  rpt #12 { rlax r12
  rpt #13 { rlax r12
  rpt #14 { rlax r12
  rpt #15 { rlax r12
  rpt #16 { rlax r12

// CHECK-LABEL: rlax:
// CHECK: rlax	r12                             ; encoding: [0x40,0x18,0x0c,0x5c]
// CHECK: rlax	r12                             ; encoding: [0x40,0x18,0x0c,0x5c]
// CHECK: rpt	#2	{	rlax	r12     ; encoding: [0x41,0x18,0x0c,0x5c]
// CHECK: rpt	#3	{	rlax	r12     ; encoding: [0x42,0x18,0x0c,0x5c]
// CHECK: rpt	#4	{	rlax	r12     ; encoding: [0x43,0x18,0x0c,0x5c]
// CHECK: rpt	#5	{	rlax	r12     ; encoding: [0x44,0x18,0x0c,0x5c]
// CHECK: rpt	#6	{	rlax	r12     ; encoding: [0x45,0x18,0x0c,0x5c]
// CHECK: rpt	#7	{	rlax	r12     ; encoding: [0x46,0x18,0x0c,0x5c]
// CHECK: rpt	#8	{	rlax	r12     ; encoding: [0x47,0x18,0x0c,0x5c]
// CHECK: rpt	#9	{	rlax	r12     ; encoding: [0x48,0x18,0x0c,0x5c]
// CHECK: rpt	#10	{	rlax	r12     ; encoding: [0x49,0x18,0x0c,0x5c]
// CHECK: rpt	#11	{	rlax	r12     ; encoding: [0x4a,0x18,0x0c,0x5c]
// CHECK: rpt	#12	{	rlax	r12     ; encoding: [0x4b,0x18,0x0c,0x5c]
// CHECK: rpt	#13	{	rlax	r12     ; encoding: [0x4c,0x18,0x0c,0x5c]
// CHECK: rpt	#14	{	rlax	r12     ; encoding: [0x4d,0x18,0x0c,0x5c]
// CHECK: rpt	#15	{	rlax	r12     ; encoding: [0x4e,0x18,0x0c,0x5c]
// CHECK: rpt	#16	{	rlax	r12     ; encoding: [0x4f,0x18,0x0c,0x5c]

rlax_b:
  rlax.b r12
  rpt #1 { rlax.b r12
  rpt #2 { rlax.b r12
  rpt #3 { rlax.b r12
  rpt #4 { rlax.b r12
  rpt #5 { rlax.b r12
  rpt #6 { rlax.b r12
  rpt #7 { rlax.b r12
  rpt #8 { rlax.b r12
  rpt #9 { rlax.b r12
  rpt #10 { rlax.b r12
  rpt #11 { rlax.b r12
  rpt #12 { rlax.b r12
  rpt #13 { rlax.b r12
  rpt #14 { rlax.b r12
  rpt #15 { rlax.b r12
  rpt #16 { rlax.b r12

// CHECK-LABEL: rlax_b:
// CHECK-NEXT: rlax.b	r12                             ; encoding: [0x40,0x18,0x4c,0x5c]
// CHECK: rlax.b	r12                             ; encoding: [0x40,0x18,0x4c,0x5c]
// CHECK: rpt	#2	{	rlax.b	r12     ; encoding: [0x41,0x18,0x4c,0x5c]
// CHECK: rpt	#3	{	rlax.b	r12     ; encoding: [0x42,0x18,0x4c,0x5c]
// CHECK: rpt	#4	{	rlax.b	r12     ; encoding: [0x43,0x18,0x4c,0x5c]
// CHECK: rpt	#5	{	rlax.b	r12     ; encoding: [0x44,0x18,0x4c,0x5c]
// CHECK: rpt	#6	{	rlax.b	r12     ; encoding: [0x45,0x18,0x4c,0x5c]
// CHECK: rpt	#7	{	rlax.b	r12     ; encoding: [0x46,0x18,0x4c,0x5c]
// CHECK: rpt	#8	{	rlax.b	r12     ; encoding: [0x47,0x18,0x4c,0x5c]
// CHECK: rpt	#9	{	rlax.b	r12     ; encoding: [0x48,0x18,0x4c,0x5c]
// CHECK: rpt	#10	{	rlax.b	r12     ; encoding: [0x49,0x18,0x4c,0x5c]
// CHECK: rpt	#11	{	rlax.b	r12     ; encoding: [0x4a,0x18,0x4c,0x5c]
// CHECK: rpt	#12	{	rlax.b	r12     ; encoding: [0x4b,0x18,0x4c,0x5c]
// CHECK: rpt	#13	{	rlax.b	r12     ; encoding: [0x4c,0x18,0x4c,0x5c]
// CHECK: rpt	#14	{	rlax.b	r12     ; encoding: [0x4d,0x18,0x4c,0x5c]
// CHECK: rpt	#15	{	rlax.b	r12     ; encoding: [0x4e,0x18,0x4c,0x5c]
// CHECK: rpt	#16	{	rlax.b	r12     ; encoding: [0x4f,0x18,0x4c,0x5c]

// Test parsing of "rpt" when it's on it's own line.
rrux2:
  rpt #1
  rrux r12
  rpt #2
  rrux r12
  rpt #3
  rrux r12
  rpt #4
  rrux r12
  rpt #5
  rrux r12
  rpt #6
  rrux r12
  rpt #7
  rrux r12
  rpt #8
  rrux r12
  rpt #9
  rrux r12
  rpt #10
  rrux r12
  rpt #11
  rrux r12
  rpt #12
  rrux r12
  rpt #13
  rrux r12
  rpt #14
  rrux r12
  rpt #15
  rrux r12
  rpt #16
  rrux r12

// CHECK-LABEL: rrux2:
// CHECK-NEXT: rrux	r12                             ; encoding: [0x40,0x19,0x0c,0x10]
// CHECK: rpt	#2	{	rrux	r12     ; encoding: [0x41,0x19,0x0c,0x10]
// CHECK: rpt	#3	{	rrux	r12     ; encoding: [0x42,0x19,0x0c,0x10]
// CHECK: rpt	#4	{	rrux	r12     ; encoding: [0x43,0x19,0x0c,0x10]
// CHECK: rpt	#5	{	rrux	r12     ; encoding: [0x44,0x19,0x0c,0x10]
// CHECK: rpt	#6	{	rrux	r12     ; encoding: [0x45,0x19,0x0c,0x10]
// CHECK: rpt	#7	{	rrux	r12     ; encoding: [0x46,0x19,0x0c,0x10]
// CHECK: rpt	#8	{	rrux	r12     ; encoding: [0x47,0x19,0x0c,0x10]
// CHECK: rpt	#9	{	rrux	r12     ; encoding: [0x48,0x19,0x0c,0x10]
// CHECK: rpt	#10	{	rrux	r12     ; encoding: [0x49,0x19,0x0c,0x10]
// CHECK: rpt	#11	{	rrux	r12     ; encoding: [0x4a,0x19,0x0c,0x10]
// CHECK: rpt	#12	{	rrux	r12     ; encoding: [0x4b,0x19,0x0c,0x10]
// CHECK: rpt	#13	{	rrux	r12     ; encoding: [0x4c,0x19,0x0c,0x10]
// CHECK: rpt	#14	{	rrux	r12     ; encoding: [0x4d,0x19,0x0c,0x10]
// CHECK: rpt	#15	{	rrux	r12     ; encoding: [0x4e,0x19,0x0c,0x10]
// CHECK: rpt	#16	{	rrux	r12     ; encoding: [0x4f,0x19,0x0c,0x10]

rrax2:
  rpt #1
  rrax r12
  rpt #2
  rrax r12
  rpt #3
  rrax r12
  rpt #4
  rrax r12
  rpt #5
  rrax r12
  rpt #6
  rrax r12
  rpt #7
  rrax r12
  rpt #8
  rrax r12
  rpt #9
  rrax r12
  rpt #10
  rrax r12
  rpt #11
  rrax r12
  rpt #12
  rrax r12
  rpt #13
  rrax r12
  rpt #14
  rrax r12
  rpt #15
  rrax r12
  rpt #16
  rrax r12

// CHECK-LABEL: rrax2:
// CHECK-NEXT: rrax	r12                             ; encoding: [0x40,0x18,0x0c,0x11]
// CHECK: rpt	#2	{	rrax	r12     ; encoding: [0x41,0x18,0x0c,0x11]
// CHECK: rpt	#3	{	rrax	r12     ; encoding: [0x42,0x18,0x0c,0x11]
// CHECK: rpt	#4	{	rrax	r12     ; encoding: [0x43,0x18,0x0c,0x11]
// CHECK: rpt	#5	{	rrax	r12     ; encoding: [0x44,0x18,0x0c,0x11]
// CHECK: rpt	#6	{	rrax	r12     ; encoding: [0x45,0x18,0x0c,0x11]
// CHECK: rpt	#7	{	rrax	r12     ; encoding: [0x46,0x18,0x0c,0x11]
// CHECK: rpt	#8	{	rrax	r12     ; encoding: [0x47,0x18,0x0c,0x11]
// CHECK: rpt	#9	{	rrax	r12     ; encoding: [0x48,0x18,0x0c,0x11]
// CHECK: rpt	#10	{	rrax	r12     ; encoding: [0x49,0x18,0x0c,0x11]
// CHECK: rpt	#11	{	rrax	r12     ; encoding: [0x4a,0x18,0x0c,0x11]
// CHECK: rpt	#12	{	rrax	r12     ; encoding: [0x4b,0x18,0x0c,0x11]
// CHECK: rpt	#13	{	rrax	r12     ; encoding: [0x4c,0x18,0x0c,0x11]
// CHECK: rpt	#14	{	rrax	r12     ; encoding: [0x4d,0x18,0x0c,0x11]
// CHECK: rpt	#15	{	rrax	r12     ; encoding: [0x4e,0x18,0x0c,0x11]
// CHECK: rpt	#16	{	rrax	r12     ; encoding: [0x4f,0x18,0x0c,0x11]

rlax2:
  rpt #1
  rlax r12
  rpt #2
  rlax r12
  rpt #3
  rlax r12
  rpt #4
  rlax r12
  rpt #5
  rlax r12
  rpt #6
  rlax r12
  rpt #7
  rlax r12
  rpt #8
  rlax r12
  rpt #9
  rlax r12
  rpt #10
  rlax r12
  rpt #11
  rlax r12
  rpt #12
  rlax r12
  rpt #13
  rlax r12
  rpt #14
  rlax r12
  rpt #15
  rlax r12
  rpt #16
  rlax r12

// CHECK-LABEL: rlax2:
// CHECK-NEXT: rlax	r12                             ; encoding: [0x40,0x18,0x0c,0x5c]
// CHECK: rpt	#2	{	rlax	r12     ; encoding: [0x41,0x18,0x0c,0x5c]
// CHECK: rpt	#3	{	rlax	r12     ; encoding: [0x42,0x18,0x0c,0x5c]
// CHECK: rpt	#4	{	rlax	r12     ; encoding: [0x43,0x18,0x0c,0x5c]
// CHECK: rpt	#5	{	rlax	r12     ; encoding: [0x44,0x18,0x0c,0x5c]
// CHECK: rpt	#6	{	rlax	r12     ; encoding: [0x45,0x18,0x0c,0x5c]
// CHECK: rpt	#7	{	rlax	r12     ; encoding: [0x46,0x18,0x0c,0x5c]
// CHECK: rpt	#8	{	rlax	r12     ; encoding: [0x47,0x18,0x0c,0x5c]
// CHECK: rpt	#9	{	rlax	r12     ; encoding: [0x48,0x18,0x0c,0x5c]
// CHECK: rpt	#10	{	rlax	r12     ; encoding: [0x49,0x18,0x0c,0x5c]
// CHECK: rpt	#11	{	rlax	r12     ; encoding: [0x4a,0x18,0x0c,0x5c]
// CHECK: rpt	#12	{	rlax	r12     ; encoding: [0x4b,0x18,0x0c,0x5c]
// CHECK: rpt	#13	{	rlax	r12     ; encoding: [0x4c,0x18,0x0c,0x5c]
// CHECK: rpt	#14	{	rlax	r12     ; encoding: [0x4d,0x18,0x0c,0x5c]
// CHECK: rpt	#15	{	rlax	r12     ; encoding: [0x4e,0x18,0x0c,0x5c]
// CHECK: rpt	#16	{	rlax	r12     ; encoding: [0x4f,0x18,0x0c,0x5c]

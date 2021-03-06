// RUN: llvm-mc -triple=arm64-none-linux-gnu -filetype=obj < %s | llvm-objdump -t - | FileCheck %s

        .text
        add w0, w0, w0

// .wibble should *not* inherit .text's mapping symbol. It's a completely different section.
        .section .wibble
        add w0, w0, w0

// A setion should be able to start with a $d
        .section .starts_data
        .word 42

// Changing back to .text should not emit a redundant $x
        .text
        add w0, w0, w0

// With all those constraints, we want:
//   + .text to have $x at 0 and no others
//   + .wibble to have $x at 0
//   + .starts_data to have $d at 0


// CHECK: 00000000 .starts_data 00000000 $d
// CHECK-NEXT: 00000000 .text 00000000 $x
// CHECK-NEXT: 00000000 .wibble 00000000 $x
// CHECK-NOT: ${{[adtx]}}


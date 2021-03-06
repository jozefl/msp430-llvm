// RUN: not clang-tidy %s --checks='-*,google-explicit-constructor' 2>&1 | FileCheck %s

// NOLINTBEGIN(google-explicit-constructor)
class A { A(int i); };
// NOLINTEND(google-explicit-constructo) <-- typo: missing 'r' 

// Note: the expected output has been split over several lines so that clang-tidy
//       does not see the "no lint" suppression comment and mistakenly assume it
//       is meant for itself.
// CHECK: :[[@LINE-7]]:4: error: unmatched 'NOLIN
// CHECK: TBEGIN' comment without a subsequent 'NOLIN
// CHECK: TEND' comment [clang-tidy-nolint]
// CHECK: :[[@LINE-9]]:11: warning: single-argument constructors must be marked explicit

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=armv7-unknown-linux < %s | FileCheck --check-prefix=CHECK-ARM %s
; RUN: llc -mtriple=thumbv6-unknown-linux < %s | FileCheck --check-prefix=CHECK-THUMB1 %s
; RUN: llc -mtriple=thumbv7-unknown-linux < %s | FileCheck --check-prefix=CHECK-THUMB2 %s

define i32 @test_slt1(i64 %a, i64 %b) {
; CHECK-ARM-LABEL: test_slt1:
; CHECK-ARM:       @ %bb.0: @ %entry
; CHECK-ARM-NEXT:    subs r0, r0, r2
; CHECK-ARM-NEXT:    mov r12, #2
; CHECK-ARM-NEXT:    sbcs r0, r1, r3
; CHECK-ARM-NEXT:    movwlt r12, #1
; CHECK-ARM-NEXT:    mov r0, r12
; CHECK-ARM-NEXT:    bx lr
;
; CHECK-THUMB1-LABEL: test_slt1:
; CHECK-THUMB1:       @ %bb.0: @ %entry
; CHECK-THUMB1-NEXT:    subs r0, r0, r2
; CHECK-THUMB1-NEXT:    sbcs r1, r3
; CHECK-THUMB1-NEXT:    bge .LBB0_2
; CHECK-THUMB1-NEXT:  @ %bb.1: @ %bb1
; CHECK-THUMB1-NEXT:    movs r0, #1
; CHECK-THUMB1-NEXT:    bx lr
; CHECK-THUMB1-NEXT:  .LBB0_2: @ %bb2
; CHECK-THUMB1-NEXT:    movs r0, #2
; CHECK-THUMB1-NEXT:    bx lr
;
; CHECK-THUMB2-LABEL: test_slt1:
; CHECK-THUMB2:       @ %bb.0: @ %entry
; CHECK-THUMB2-NEXT:    subs r0, r0, r2
; CHECK-THUMB2-NEXT:    mov.w r12, #2
; CHECK-THUMB2-NEXT:    sbcs.w r0, r1, r3
; CHECK-THUMB2-NEXT:    it lt
; CHECK-THUMB2-NEXT:    movlt.w r12, #1
; CHECK-THUMB2-NEXT:    mov r0, r12
; CHECK-THUMB2-NEXT:    bx lr
entry:
  %cmp = icmp slt i64 %a, %b
  br i1 %cmp, label %bb1, label %bb2
bb1:
  ret i32 1
bb2:
  ret i32 2
}

define void @test_slt2(i64 %a, i64 %b) {
; CHECK-ARM-LABEL: test_slt2:
; CHECK-ARM:       @ %bb.0: @ %entry
; CHECK-ARM-NEXT:    push {r11, lr}
; CHECK-ARM-NEXT:    subs r0, r0, r2
; CHECK-ARM-NEXT:    sbcs r0, r1, r3
; CHECK-ARM-NEXT:    bge .LBB1_2
; CHECK-ARM-NEXT:  @ %bb.1: @ %bb1
; CHECK-ARM-NEXT:    bl f
; CHECK-ARM-NEXT:    pop {r11, pc}
; CHECK-ARM-NEXT:  .LBB1_2: @ %bb2
; CHECK-ARM-NEXT:    bl g
; CHECK-ARM-NEXT:    pop {r11, pc}
;
; CHECK-THUMB1-LABEL: test_slt2:
; CHECK-THUMB1:       @ %bb.0: @ %entry
; CHECK-THUMB1-NEXT:    push {r7, lr}
; CHECK-THUMB1-NEXT:    subs r0, r0, r2
; CHECK-THUMB1-NEXT:    sbcs r1, r3
; CHECK-THUMB1-NEXT:    bge .LBB1_2
; CHECK-THUMB1-NEXT:  @ %bb.1: @ %bb1
; CHECK-THUMB1-NEXT:    bl f
; CHECK-THUMB1-NEXT:    pop {r7, pc}
; CHECK-THUMB1-NEXT:  .LBB1_2: @ %bb2
; CHECK-THUMB1-NEXT:    bl g
; CHECK-THUMB1-NEXT:    pop {r7, pc}
;
; CHECK-THUMB2-LABEL: test_slt2:
; CHECK-THUMB2:       @ %bb.0: @ %entry
; CHECK-THUMB2-NEXT:    push {r7, lr}
; CHECK-THUMB2-NEXT:    subs r0, r0, r2
; CHECK-THUMB2-NEXT:    sbcs.w r0, r1, r3
; CHECK-THUMB2-NEXT:    bge .LBB1_2
; CHECK-THUMB2-NEXT:  @ %bb.1: @ %bb1
; CHECK-THUMB2-NEXT:    bl f
; CHECK-THUMB2-NEXT:    pop {r7, pc}
; CHECK-THUMB2-NEXT:  .LBB1_2: @ %bb2
; CHECK-THUMB2-NEXT:    bl g
; CHECK-THUMB2-NEXT:    pop {r7, pc}
entry:
  %cmp = icmp slt i64 %a, %b
  br i1 %cmp, label %bb1, label %bb2
bb1:
  call void @f()
  ret void
bb2:
  call void @g()
  ret void
}

declare void @f()
declare void @g()

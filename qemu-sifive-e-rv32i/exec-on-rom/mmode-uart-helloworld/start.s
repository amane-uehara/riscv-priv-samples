.GLOBAL _start
.GLOBAL main

.SECTION .text

_start:
  # stop all hart except hart0
  csrr  t0      , mhartid
  bnez  t0      , _wait_for_intr

  # initialize stack pointer
  la    sp      , _init_stack_ptr

  jal             main
  j               _wait_for_intr

_wait_for_intr:
  wfi
  j               _wait_for_intr

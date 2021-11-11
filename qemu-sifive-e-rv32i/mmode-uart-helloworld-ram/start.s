.GLOBAL _start
.GLOBAL main

.SECTION .text

_start:
  # initialize stack pointer
  la          sp, _init_stack_ptr

  jal         main
  j           _wait_for_intr

_wait_for_intr:
  wfi
  j           _wait_for_intr

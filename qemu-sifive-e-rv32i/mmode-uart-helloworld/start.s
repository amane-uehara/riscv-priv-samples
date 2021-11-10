.GLOBAL _start
.GLOBAL main
.GLOBAL _stack_end
.EQU STACK_SIZE, 1024

.SECTION .text

_start:
  # initialize stack pointer
  la          sp, _stack_end + STACK_SIZE

  jal         main
  j           _wait_for_intr

_wait_for_intr:
  wfi
  j           _wait_for_intr



.SECTION .bss
.ALIGN 4

_stack_end:
  .SKIP STACK_SIZE

.GLOBAL _start
.GLOBAL _init_stack_ptr
.GLOBAL _trap_vector
.GLOBAL _uart_init
.SECTION .text

_start:
  # stop all hart except hart0
  csrr  t0      , mhartid
  bnez  t0      , _wait_for_intr

  # interrupt disable
  csrw  mstatus , zero
  csrw  mie     , zero

  # initialize stack pointer
  la    sp      , _init_stack_ptr

  # initialize uart device
  jal             _uart_init

  # set interrupt vector
  la    t0      , _trap_vector
  csrw  mtvec   , t0

  # interrupt enable
  li    t0      , 0x8
  csrw  mstatus , t0
  li    t0      , 0x888
  csrw  mie     , t0

  j               _wait_for_intr

_wait_for_intr:
  wfi
  j             _wait_for_intr

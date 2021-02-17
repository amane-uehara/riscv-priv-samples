.GLOBAL _start
.GLOBAL _init_stack_ptr
.GLOBAL _trap_vector
.GLOBAL _uart_init
.SECTION .text

_start:
  # stop all hart except hart0
  csrr  t0      , mhartid
  bnez  t0      , _wait_for_intr

  # initialize stack pointer
  la    sp      , _init_stack_ptr

  # interrupt disable
  csrr  t0      , mstatus
  li    t1      , 0xFFFFFFF7 # ~(1 << 3)
  and   t0      , t0 , t1
  csrw  mstatus , t0         # mstatus = mstatus(MIE=0)
  csrw  mie     , zero

  # initialize uart device
  jal             _uart_init

  # set interrupt vector
  la    t0      , _trap_vector
  csrw  mtvec   , t0

  # interrupt enable
  csrr  t0      , mstatus
  li    t1      , 0x8        # (1 << 3)
  or    t0      , t0 , t1
  csrw  mstatus , t0         # mstatus = mstatus(MIE=1)
  li    t0      , 0x800      # (1 << 11)
  csrw  mie     , t0         # mie.MEIE = 1

  j               _wait_for_intr

_wait_for_intr:
  wfi
  j             _wait_for_intr

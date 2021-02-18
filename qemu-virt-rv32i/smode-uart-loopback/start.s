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
  li    t1      , 0xFFFFFFF7 # ~(1 << 3) ... mstatus.MIE
  and   t0      , t0 , t1
  li    t1      , 0xFFFFFFFD # ~(1 << 1) ... mstatus.SIE
  and   t0      , t0 , t1
  csrw  mstatus , t0         # mstatus = mstatus(MIE=0, SIE=0)
  csrw  mie     , zero       # mie=0, sie=0

  # interrupt delegation
  li    t0      , 0xFFFF
  csrw  mideleg , t0
  csrw  medeleg , t0

  # prepare for entering supervisor mode
  csrr  t0      , mstatus
  li    t1      , 0xFFFFE7FF # ~(3 << 11) ... mstatus.MPP = 0x00
  and   t0      , t0 , t1
  li    t1      , 0x00000800 #  (1 << 11) ... mstatus.MPP = 0x01
  or    t0      , t0 , t1
  csrw  mstatus , t0         # mstatus.MPP = 0x01

  la    t0      , _enter_smode
  csrw  mepc    , t0
  csrw  satp    , zero

  mret

_enter_smode:
  # initialize uart device
  jal             _uart_init

  # set interrupt vector
  la    t0      , _trap_vector
  csrw  stvec   , t0

  # interrupt enable
  csrr  t0      , sstatus
  li    t1      , 0x2        # (1 << 1)
  or    t0      , t0 , t1
  csrw  sstatus , t0         # sstatus = sstatus(SIE=1)
  li    t0      , 0x200      # (1 << 9)
  csrw  sie     , t0         # sie.SEIE = 1

  j               _wait_for_intr

_wait_for_intr:
  wfi
  j             _wait_for_intr

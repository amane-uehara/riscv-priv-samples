.GLOBAL _start
.GLOBAL _init_stack_ptr
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

  # set interrupt vector
  la    t0      , _trap_vector
  csrw  mtvec   , t0

  # system call
  ecall                      # t5 = mcause = 0xB (Environment call from M-mode)
  li    t6      , 0x22222222 # this will be executed after ecall (t6 = 0x11111111)

  j               _wait_for_intr

_wait_for_intr:
  wfi
  j             _wait_for_intr

_trap_vector:
  # memo
  csrr    t5   , mcause

  # update mepc
  csrr    a0   , mepc
  addi    a0   , a0, 4
  csrw    mepc , a0

  # Return
  mret

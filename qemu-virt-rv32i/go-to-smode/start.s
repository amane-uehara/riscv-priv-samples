.GLOBAL _start

.SECTION .text

_start:
  csrr  t0      , mhartid
  bnez  t0      , _wait_for_interrupt

  # set mcause.MPP=01 (S-MODE)
  csrr  t0      , mstatus
  li    t1      , 0xFFFFE7FF
  and   t0      , t0 , t1
  li    t1      , 0x00000800
  or    t0      , t0 , t1
  csrw  mstatus , t0

  # set entry address for S-MODE
  la    t0      , _s_mode_entry
  csrw  mepc    , t0

  # disable virtual address
  csrw  satp    , zero

  # go to S-MODE
  mret

_s_mode_entry:
  j     _end

_end:
  j     _end

_wait_for_interrupt:
  wfi
  j     _wait_for_interrupt

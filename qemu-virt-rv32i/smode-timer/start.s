.GLOBAL _start
.GLOBAL _timer_add
.GLOBAL trap_vector
.GLOBAL _wait_for_intr
.GLOBAL main
.GLOBAL smode_entry

.SECTION .text

_start:
  # stop all hart except hart0
  csrr t0 , mhartid
  bnez t0 , _wait_for_intr

  # initialize stack pointer
  la   sp , _init_stack_ptr

  jal  main
  j    _wait_for_intr

_wait_for_intr:
  wfi
  j    _wait_for_intr

_timer_add:
  li a1 , 0x200bff8 # CLINT MTIME_ADDRESS
  lw a2 , 0(a1)
  lw a3 , 4(a1)

  add  a4 , a2 , a0
  sltu a2 , a4 , a2
  add  a3 , a3 , a2

  li a1 , 0x2004000 # CLINT MTIMECMP ADDRESS
  sw a4 , 0(a1)
  sw a3 , 4(a1)

  ret

main:
  # disable all interrupt
  csrr t0, mstatus
  li   t1, 0xFFFFFFF7 # x &= ~(1 << 3); // mstatus.MIE
  and  t0, t0, t1
  csrw mstatus, t0
  csrw mie, zero

  # timer interrupt delegation
  li   t0, 0xFFFF # x = 0xffff
  csrw mideleg, t0
  csrw medeleg, t0

  # goto supervisor mode
  csrr t0, mstatus
  li   t1, 0xFFFF7EFF # x &= ~(3 << 11);
  and  t0, t0, t1
  li   t1, 0x00000800 # x |= (1 << 11);
  or   t0, t0, t1
  csrw mstatus, t0

  la   t0, smode_entry
  csrw mepc, t0

  mret

smode_entry:
  # set trap vector
  la t0, trap_vector;
  csrw stvec, t0

  # init timer
  li a0, 100000
  jal _timer_add

  # enable timer interrupt
  csrr t0, sstatus
  li   t1, 2 # x |= 1 << 1; // sstatus.SIE
  or   t0, t0, t1
  csrw sstatus, t0
  li   t0, 0x20 # x = 1 << 5;  // sie.STIE
  csrw sie, t0

  ret

trap_vector:
  # memo timer count
  addi x31, x31, 1

  # set time span for next timer interrupt
  li   a0 , 100000
  jal  _timer_add
  sret

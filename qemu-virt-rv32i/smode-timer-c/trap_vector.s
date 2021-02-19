.GLOBAL _trap_vector
.GLOBAL _timer_add
.SECTION .text

_trap_vector:
  addi x31, x31, 1
  li   a0 , 100000
  jal  _timer_add
  sret

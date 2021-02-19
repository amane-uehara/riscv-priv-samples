.GLOBAL _timer_add
.SECTION .text

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

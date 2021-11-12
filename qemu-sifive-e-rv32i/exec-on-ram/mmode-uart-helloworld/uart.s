.GLOBAL _uart_send
.SECTION .text

_uart_send:
  li    a4 , 0x10013000 # UART THR ADDR

_thr_check_loop:
  lw    a1 , 0(a4)
  bne   a1 , zero , _thr_check_loop

  sw    a0 , 0(a4)
  ret

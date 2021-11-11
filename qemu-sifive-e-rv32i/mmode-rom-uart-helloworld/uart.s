.GLOBAL _uart_send
.SECTION .text

_uart_send:
  li    a4   , 0x10013000 # UART THR ADDR
  sb    a0   , 0(a4)
  ret

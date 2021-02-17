.GLOBAL _uart_send
.SECTION .text

_uart_send:
  li   a4 , 0x10000005 # UART LSR ADDR
  lb   a5 , 0(a4)
  andi a5 , a5 , 0x40  # UART LSR (RI)
  beqz a5 , _uart_send

  li   a4 , 0x10000000 # UART THR ADDR
  andi a0 , a0 , 0xff
  sb   a0 , 0(a4)
  ret

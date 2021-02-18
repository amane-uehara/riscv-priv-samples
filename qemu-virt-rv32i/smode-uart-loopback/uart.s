.include "memory_map.s"
.GLOBAL _uart_init
.GLOBAL _uart_send
.GLOBAL _uart_receive
.SECTION .text

_uart_init:
  # set desired IRQ priorities non-zero (otherwise disabled).
  # *(uint32*)(PLIC + UART0_IRQ*4) = 1;
  li  a4 , CONST_PLIC_UART0_PRIORITY_ADDR
  li  a0 , 1
  sw  a0 , 0(a4)

  # set uart's enable bit for this hart's M-mode.
  # *(uint32*)PLIC_MENABLE(hart) = (1 << UART0_IRQ)
  # 0x0c000000 + 0x2000 + (0)*0x2000 = (1 << 10)
  # 0x0c200000 = 0x400
  li  a4 , CONST_PLIC_ENABLE_BIT_ADDR
  li  a0 , 0x400
  sw  a0 , 0(a4)

  # (PLIC + 0x200000 + (0)*0x2000) = 0
  li  a4 , CONST_PLIC_PRIORITY_BIT_ADDR
  li  a0 , 0x0
  sw  a0 , 0(a4)

  # uart ns16650 interrupt enable
  li  a4 , CONST_UART_IER_ADDR
  li  a0 , CONST_UART_IER_IE
  sb  a0 , 0(a4)

  ret

_uart_send:
  li   a4 , CONST_UART_LSR_ADDR
  lb   a5 , 0(a4)
  andi a5 , a5 , CONST_UART_LSR_RI
  beqz a5 , _uart_send

  li   a4 , CONST_UART_THR_ADDR
  andi a0 , a0 , 0xff
  sb   a0 , 0(a4)
  ret

_uart_receive:
  li   a4 , CONST_UART_RHR_ADDR
  lbu  a0 , 0(a4)
  andi a0 , a0 , 0xff
  ret

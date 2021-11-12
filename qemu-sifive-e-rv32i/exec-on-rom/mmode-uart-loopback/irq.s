.include "memory_map.s"
.GLOBAL _save_irq
.GLOBAL _load_irq
.SECTION .text

_load_irq:
  li a1 , CONST_PLIC_IRQ_ADDR
  lw a0 , 0(a1)
  ret

_save_irq:
  li a1 , CONST_PLIC_IRQ_ADDR
  sw a0 , 0(a1)
  ret

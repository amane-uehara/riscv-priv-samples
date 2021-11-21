# PLIC IRQ (memory mapped)
# PLIC_BASE_ADDR  : 0x0C000000
# irq (UART0_IRQ) : 3 = 0x3
# hart            : 0

# [M-MODE, S-MODE] plic priority addr
# ADDR  : PLIC_BASE_ADDR + irq*4
# VALUE : non-zero (1)
# MEM[0x0C000028] = 0x00000001
.equ CONST_PLIC_UART0_PRIORITY_ADDR , 0x0C00000C

# [M-MODE] set uart's enable bit for this hart's.
# ADDR(hart) = PLIC_BASE_ADDR + 0x2000 + hart*0x2000
# VALUE(irq) = (1 << irq) = 0x8
# MEM[0x0C002000] = 0x00000008
.equ CONST_PLIC_ENABLE_BIT_ADDR , 0x0C002000

# [S-MODE] set uart's enable bit for this hart's.
# ADDR(hart) = PLIC_BASE_ADDR + 0x2080 + hart*0x2000
# VALUE(irq) = (1 << irq) = 0x8
# MEM[0x0C002080] = 0x00000008

# [M-MODE] set plic priority
# ADDR(hart) = PLIC_BASE_ADDR + 0x200000 + hart*0x2000
# VALUE      = 0
# MEM[0x0C200000] = 0x00000000
.equ CONST_PLIC_PRIORITY_BIT_ADDR , 0x0C200000

# [S-MODE] set plic priority
# ADDR(hart) = PLIC_BASE_ADDR + 0x201000 + hart*0x2000
# VALUE      = 0
# MEM[0x0C201000] = 0x00000000

# [M-MODE] irq address
# ADDR : PLIC_BASE_ADDR + 0x200004 + hart*0x2000
.equ CONST_PLIC_IRQ_ADDR , 0x0C200004

# [S-MODE] irq address
# ADDR : PLIC_BASE_ADDR + 0x201004 + hart*0x2000

# UART
.equ CONST_UART_IER_ADDR , 0x10013010
.equ CONST_UART_THR_ADDR , 0x10013000
.equ CONST_UART_RHR_ADDR , 0x10013004
#.equ CONST_UART_LSR_ADDR , 0x10000005
.equ CONST_UART_IER_IE   , 0x01
#.equ CONST_UART_LSR_RI   , 0x40

.equ CONST_INIT_STACK_PTR , 0x80001000

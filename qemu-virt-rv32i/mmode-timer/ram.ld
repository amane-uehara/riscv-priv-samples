OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv", "elf32-littleriscv")
OUTPUT_ARCH("riscv")
ENTRY(_start)

SECTIONS {
  . = 0x80000000;

  .text : {
    */start.o (.text);
    *(.text)
  }

  _init_stack_ptr   = 0x80010000;
}

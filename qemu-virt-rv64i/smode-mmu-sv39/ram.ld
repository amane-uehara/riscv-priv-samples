OUTPUT_FORMAT("elf64-littleriscv", "elf64-littleriscv", "elf64-littleriscv")
OUTPUT_ARCH("riscv")
ENTRY(start)

SECTIONS {
  . = 0x80000000;

  .text : {
    */start.o (.text);
    *(.text)
  }
}

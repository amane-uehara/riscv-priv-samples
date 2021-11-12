OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv", "elf32-littleriscv")
OUTPUT_ARCH("riscv")
ENTRY(_start)

MEMORY {
  ROM   (rxai!w) : ORIGIN = 0x20400000, LENGTH = 1M
  RAM   (wxa!ri) : ORIGIN = 0x80000000, LENGTH = 1M
}

SECTIONS {
  .text : {
    */start.o (.text);
    * (.text);
  } > RAM AT > ROM

  .rodata : {
    * (.rodata)
  } > RAM AT > ROM

  .data : {
    * (.sdata)
    * (.data)
  } > RAM AT > ROM

  .bss : {
    * (.sbss .sbss.*)
    * (.bss)
  } > RAM AT > ROM

  _init_stack_ptr   = 0x80001000;
}

OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv", "elf32-littleriscv")
OUTPUT_ARCH("riscv")
ENTRY(_start)

MEMORY {
  flash (rxai!w) : ORIGIN = 0x20400000, LENGTH = 128M
  ram   (wxa!ri) : ORIGIN = 0x80000000, LENGTH = 64K
}

SECTIONS {
  .text : {
    */start.o (.text);
    * (.text);
  }

  .rodata : {
    * (.rodata)
  }

  .data : {
    * (.sdata)
    * (.data)
  }

  .bss : {
    * (.sbss .sbss.*)
    * (.bss)
  }
}

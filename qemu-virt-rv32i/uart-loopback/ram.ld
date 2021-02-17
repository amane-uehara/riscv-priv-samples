OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv", "elf32-littleriscv")
OUTPUT_ARCH("riscv")
ENTRY(_start)

SECTIONS {
  . = 0x80000000;

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

  .text : {
    * (.filesystem_bin)
  }

  _init_stack_ptr   = 0x80010000;
  _user_program_ptr = 0x80020000;
}

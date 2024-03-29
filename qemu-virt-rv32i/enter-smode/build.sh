#!/bin/sh
riscv64-unknown-elf-gcc \
  -Os \
  -march=rv32i \
  -mabi=ilp32 \
  -mcmodel=medany \
  -ffunction-sections \
  -fdata-sections \
  -o build/start.o \
  -c start.s

riscv64-unknown-elf-gcc \
  -Os \
  -march=rv32i \
  -mabi=ilp32 \
  -mcmodel=medany \
  -ffunction-sections \
  -fdata-sections \
  -nostartfiles \
  -nostdlib \
  -nostdinc \
  -static \
  -lgcc \
  -Wl,--nmagic \
  -Wl,--gc-sections \
  -o build/start.elf \
  -T ram.ld \
  build/start.o

qemu-system-riscv32 \
  -nographic \
  -machine virt \
  -bios none \
  -kernel build/start.elf

#!/bin/sh
riscv32-unknown-linux-gnu-gcc \
  -g \
  -Os \
  -march=rv32i \
  -mabi=ilp32 \
  -mcmodel=medany \
  -ffunction-sections \
  -fdata-sections \
  -ffreestanding \
  -o build/start.o \
  -c start.c

riscv32-unknown-linux-gnu-gcc \
  -g \
  -Os \
  -march=rv32i \
  -mabi=ilp32 \
  -mcmodel=medany \
  -ffunction-sections \
  -fdata-sections \
  -ffreestanding \
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

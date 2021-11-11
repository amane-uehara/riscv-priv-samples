#!/bin/sh
riscv64-unknown-linux-gnu-gcc \
  -Os \
  -march=rv64i \
  -mabi=lp64 \
  -mcmodel=medany \
  -ffunction-sections \
  -fdata-sections \
  -ffreestanding \
  -o build/start.o \
  -c start.c

riscv64-unknown-linux-gnu-gcc \
  -Os \
  -march=rv64i \
  -mabi=lp64 \
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

qemu-system-riscv64 \
  -nographic \
  -machine virt \
  -bios none \
  -kernel build/start.elf

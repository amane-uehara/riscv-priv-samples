# build

```sh
$ make
```

# run

```sh
$ qemu-system-riscv32 -nographic -machine sifive_e -bios none -kernel build/timer.elf
```

# how to check timer

* press CTRL + A
* press C
* type `info registers`
* check x31 register value

```

QEMU 6.0.1 monitor - type 'help' for more information
(qemu) info registers
 pc       00000000
 mhartid  00000000
 mstatus  00000180
 ...
 x24/s8 00000000 x25/s9 00000000 x26/s10 00000000 x27/s11 00000000
 x28/t3 00000000 x29/t4 00000000 x30/t5 00000000 x31/t6 00000177
 ...
(qemu)
```

# how to exit qemu

* press CTRL + A
* press X

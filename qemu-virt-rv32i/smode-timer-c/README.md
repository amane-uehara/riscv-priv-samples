# build

```sh
$ make
```

# run

```sh
$ qemu-system-riscv32 -nographic -machine virt -bios none -kernel build/timer.elf
```

# how to check timer

* press CTRL + c
* type `info registers`
* check x31 register value

```
QEMU 4.2.1 monitor - type 'help' for more information
(qemu) info registers
 pc       8000005c
 mhartid  00000000
 mstatus  00000088
 ...
 x28/t3 00000000 x29/t4 00000000 x30/t5 00000000 x31/t6 00000132
 f0/ft0 0000000000000000 f1/ft1 0000000000000000 f2/ft2 0000000000000000 f3/ft3 0000000000000000
 ...

(qemu) info registers
 pc       8000005c
 mhartid  00000000
 mstatus  00000088
 ...
 x28/t3 00000000 x29/t4 00000000 x30/t5 00000000 x31/t6 000003df
 f0/ft0 0000000000000000 f1/ft1 0000000000000000 f2/ft2 0000000000000000 f3/ft3 0000000000000000
 ...
(qemu) info registers
```

# how to exit qemu

press CTRL + X

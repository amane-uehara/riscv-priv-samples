# build

```sh
$ make
```

# run

```sh
$ qemu-system-riscv32 -nographic -machine sifive_e -bios none -kernel build/loopback.elf
(any typed character will be loop-backed)
```

# how to exit qemu

* press CTRL + C
* press X

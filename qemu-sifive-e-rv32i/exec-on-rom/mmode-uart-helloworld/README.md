# build

```sh
$ make
```

# run

```sh
$ qemu-system-riscv32 -nographic -machine sifive_e -bios none -kernel build/hello.elf
hello world
```

# how to exit qemu

* press CTRL + C
* press X

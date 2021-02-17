# build and run

```sh
$ build.sh
```

# how to check timer

* press CTRL + c
* type `info registers`
* check x31 register value

```

QEMU 4.2.1 monitor - type 'help' for more information
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

press CTRL + X

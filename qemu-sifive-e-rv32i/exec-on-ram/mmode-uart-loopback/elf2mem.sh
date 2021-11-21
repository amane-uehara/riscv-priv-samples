#!/bin/bash

riscv64-unknown-elf-objdump -d -Mno-aliases,numeric $1 \
  | egrep '(	|>:)' \
  | sed -e 's@^\([^:]*\):@/* \1 */@' \
  | sed -e 's@	@   @' \
  | sed -e 's@	@// @' \
  | sed -e 's@^\(/\*.*\*/\)$@\n\1\n@' \
  > ${1%.elf}.mem

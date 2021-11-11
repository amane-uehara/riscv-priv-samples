BUILD   := build
TARGET  := timer
RVVER   := riscv32-unknown-linux-gnu
CC      := $(RVVER)-gcc -Os -march=rv32i -mabi=ilp32 -mcmodel=medany -ffunction-sections -fdata-sections -ffreestanding
OUT     := -nostartfiles -nostdlib -nostdinc -static -lgcc -Wl,--nmagic -Wl,--gc-sections

C_FILES := $(wildcard *.c)
S_FILES := $(wildcard *.s)

O_FILES := $(patsubst %.c, $(BUILD)/%.o, $(notdir $(C_FILES)))
O_FILES += $(patsubst %.s, $(BUILD)/%.o, $(notdir $(S_FILES)))

.PHONY: $(BUILD)/$(TARGET).elf

$(BUILD)/$(TARGET).elf : ram.ld $(O_FILES)
	$(CC) $(OUT) -o $@ -T $^

$(BUILD)/%.o: %.c
	$(CC) -c $< -o $@

$(BUILD)/%.o: %.s
	$(CC) -c $< -o $@

clean:
	rm -rf ${BUILD}/*

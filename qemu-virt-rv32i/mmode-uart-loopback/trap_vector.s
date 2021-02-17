.GLOBAL _trap_vector
.GLOBAL trap_handler

.SECTION .text

_trap_vector:
    # Save registers.
    addi    sp, sp, -64
    sw      ra, 0(sp)
    sw      a0, 4(sp)
    sw      a1, 8(sp)
    sw      a2, 12(sp)
    sw      a3, 16(sp)
    sw      a4, 20(sp)
    sw      a5, 24(sp)
    sw      a6, 28(sp)
    sw      a7, 32(sp)
    sw      t0, 36(sp)
    sw      t1, 40(sp)
    sw      t2, 44(sp)
    sw      t3, 48(sp)
    sw      t4, 52(sp)
    sw      t5, 56(sp)
    sw      t6, 60(sp)

    # Invoke the handler.
    csrr    a0, mcause
    jal     trap_handler

    # Restore registers.
    lw      ra, 0(sp)
    lw      a0, 4(sp)
    lw      a1, 8(sp)
    lw      a2, 12(sp)
    lw      a3, 16(sp)
    lw      a4, 20(sp)
    lw      a5, 24(sp)
    lw      a6, 28(sp)
    lw      a7, 32(sp)
    lw      t0, 36(sp)
    lw      t1, 40(sp)
    lw      t2, 44(sp)
    lw      t3, 48(sp)
    lw      t4, 52(sp)
    lw      t5, 56(sp)
    lw      t6, 60(sp)
    addi    sp, sp, 64

    # Return
    mret

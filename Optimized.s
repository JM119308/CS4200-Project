lw      ra, 12(sp)
        lw      s0, 8(sp)
        addi    sp, sp, 16

        # Load the address of the matrix into register a0
        la      a0, matrix

        # Number of rows 
        li      a1, 8
        # Number of columns 
        li      a2, 8

        jal     avg_columns

        j      end

avg_columns:
        addi    sp, sp, -44
        sw      s0, 40(sp)
        addi    s0, sp, 44
        sw      a0, -36(s0)
        sw      a1, -40(s0)
        sw      a2, -44(s0)
        j       outer_loop

reinitialize:
        sw      zero, -20(s0)
        sw      zero, -24(s0)
        j       inner_loop

sum_column:
        lw      a4, -24(s0)
        lw      a5, -36(s0)
        slli    a4, a4, 2
        add     a4, a5, a4
        lw      a4, 0(a4)
        lw      a5, -20(s0)
        add     a4, a4, a5
        sw      a4, -20(s0)
        lw      a4, -24(s0)
        addi    a4, a4, 1
        sw      a4, -24(s0)

inner_loop:
        lw      a4, -24(s0)
        lw      a5, -40(s0)
        blt     a4, a5, sum_column
        lw      a5, -40(s0)
        lw      a4, -20(s0)
        divu    a4, a4, a5
        la      a5, avg  # Load address for avg array
        lw      a3, -16(s0)
        slli    a3, a3, 2
        add     a3, a5, a3
        sw      a4, 0(a3)
        lw      a5, -16(s0)
        addi    a5, a5, 1
        sw      a5, -16(s0)

outer_loop:
        lw      a4, -16(s0)
        lw      a5, -44(s0)
        blt     a4, a5, reinitialize
        nop
        nop
        lw      s0, 40(sp)
        addi    sp, sp, 44
        jr      ra
end:

.data
#define matrix here:
matrix:
    .word 10, 10, 5
    .word 4, 4, 2
    .word 4, 1, 2

avg:
    .word 0

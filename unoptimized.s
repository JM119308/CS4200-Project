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
        addi    sp, sp, -48
        sw      s0, 44(sp)
        addi    s0, sp, 48
        sw      a0, -36(s0)
        sw      a1, -40(s0)
        sw      a2, -44(s0)
        sw      zero, -20(s0)
        j       outer_loop

reinitialize:
        sw      zero, -24(s0)
        sw      zero, -28(s0)
        j       inner_loop

sum_column:
        lw      a4, -28(s0)
        mv      a5, a4
        slli    a5, a5, 1
        add     a5, a5, a4
        slli    a5, a5, 2
        mv      a4, a5
        lw      a5, -36(s0)
        add     a4, a5, a4
        lw      a5, -20(s0)
        slli    a5, a5, 2
        add     a5, a4, a5
        lw      a5, 0(a5)
        lw      a4, -24(s0)
        add     a5, a4, a5
        sw      a5, -24(s0)
        lw      a5, -28(s0)
        addi    a5, a5, 1
        sw      a5, -28(s0)

inner_loop:
        lw      a4, -28(s0)
        lw      a5, -40(s0)
        blt     a4, a5, sum_column
        lw      a5, -40(s0)
        lw      a4, -24(s0)
        divu    a4, a4, a5
        # Load address for avg array
        la      a5, avg  
        lw      a3, -20(s0)
        slli    a3, a3, 2
        add     a3, a5, a3
        sw      a4, 0(a3)
        lw      a5, -20(s0)
        addi    a5, a5, 1
        sw      a5, -20(s0)

outer_loop:
        lw      a4, -20(s0)
        lw      a5, -44(s0)
        blt     a4, a5, reinitialize
        nop
        nop
        lw      s0, 44(sp)
        addi    sp, sp, 48
        jr      ra
end:

.data
#define matrix here:
matrix:
    .word 10, 10, 5
    .word 6, 2, 2
    .word 2, 3, 2

avg:
    .word 0

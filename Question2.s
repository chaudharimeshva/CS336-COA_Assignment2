.data

A:
.word 1, 2, 3, 4
.word 5, 6, 7, 8
.word 9, 10, 11, 12
.word 13, 14, 15, 16

B:
.word 16, 15, 14, 13
.word 12, 11, 10, 9
.word 8, 7, 6, 5
.word 4, 3, 2, 1

C:
.space 64        # 16 words × 4 bytes

.text
.globl main

main:

    la   $t0, A       # base address of A
    la   $t1, B       # base address of B
    la   $t2, C       # base address of C

    li   $t3, 0       # counter i = 0

loop:
    beq  $t3, 16, done

    lw   $t4, 0($t0)  # load A[i]
    lw   $t5, 0($t1)  # load B[i]

    add  $t6, $t4, $t5  # C[i] = A[i] + B[i]

    sw   $t6, 0($t2)    # store in C

    addi $t0, $t0, 4    # move to next element
    addi $t1, $t1, 4
    addi $t2, $t2, 4

    addi $t3, $t3, 1    # i++
    j    loop

done:
    li   $v0, 10
    syscall

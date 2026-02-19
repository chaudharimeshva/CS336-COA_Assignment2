.data
A: .word 34, 7, 23, 32, 5, 62, 78, 1, 55, 19

.text
.globl main

main:
    la $a0, A        # base address
    li $a1, 0        # low = 0
    li $a2, 9        # high = 9
    jal quicksort

    li $v0, 10
    syscall

#################################################
# quicksort(A, low, high)
# a0 = base
# a1 = low
# a2 = high
#################################################

quicksort:
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $a1, 8($sp)
    sw $a2, 4($sp)

    bge $a1, $a2, qs_return

    jal partition

    move $t0, $v0     # pivot index

    lw $a1, 8($sp)
    addi $a2, $t0, -1
    jal quicksort

    lw $a2, 4($sp)
    addi $a1, $t0, 1
    jal quicksort

qs_return:
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra

#################################################
# partition(A, low, high)
#################################################

partition:
    addi $sp, $sp, -12
    sw $ra, 8($sp)

    move $t0, $a1       # i = low
    addi $t0, $t0, -1

    sll $t1, $a2, 2
    add $t1, $a0, $t1
    lw $t2, 0($t1)      # pivot = A[high]

    move $t3, $a1       # j = low

part_loop:
    bge $t3, $a2, part_done

    sll $t4, $t3, 2
    add $t4, $a0, $t4
    lw $t5, 0($t4)

    ble $t5, $t2, swap_needed
    j next_j

swap_needed:
    addi $t0, $t0, 1

    sll $t6, $t0, 2
    add $t6, $a0, $t6
    lw $t7, 0($t6)

    sw $t5, 0($t6)
    sw $t7, 0($t4)

next_j:
    addi $t3, $t3, 1
    j part_loop

part_done:
    addi $t0, $t0, 1

    sll $t6, $t0, 2
    add $t6, $a0, $t6
    lw $t7, 0($t6)

    sw $t2, 0($t6)
    sw $t7, 0($t1)

    move $v0, $t0

    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra

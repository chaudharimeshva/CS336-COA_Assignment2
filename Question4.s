.data
A: .word 2, 5, 8, 12, 16, 23, 38, 56, 72, 91
key1: .word 23        # existing element
key2: .word 50        # non-existing element

.text
.globl main

main:
    la  $t0, A        # base address of array
    li  $t1, 0        # low = 0
    li  $t2, 9        # high = 9

    lw  $t3, key1     # search key (existing)

search1:

    bgt $t1, $t2, not_found1

    add $t4, $t1, $t2
    srl $t4, $t4, 1   # mid = (low + high) / 2

    sll $t5, $t4, 2
    add $t6, $t0, $t5
    lw  $t7, 0($t6)   # A[mid]

    beq $t7, $t3, found1

    blt $t3, $t7, left1

    addi $t1, $t4, 1  # low = mid + 1
    j search1

left1:
    addi $t2, $t4, -1 # high = mid - 1
    j search1

found1:
    move $s0, $t4     # store index in $s0
    j second_search

not_found1:
    li $s0, -1        # -1 means not found

second_search:

    la  $t0, A
    li  $t1, 0
    li  $t2, 9

    lw  $t3, key2     # search key (non-existing)

search2:

    bgt $t1, $t2, not_found2

    add $t4, $t1, $t2
    srl $t4, $t4, 1

    sll $t5, $t4, 2
    add $t6, $t0, $t5
    lw  $t7, 0($t6)

    beq $t7, $t3, found2

    blt $t3, $t7, left2

    addi $t1, $t4, 1
    j search2

left2:
    addi $t2, $t4, -1
    j search2

found2:
    move $s1, $t4
    j done

not_found2:
    li $s1, -1

done:
    li $v0, 10
    syscall

.data
A:
.word 45, 12, 78, 3, 90, 56, 23, 11, 67, 89
.word 34, 22, 10, 5, 99, 2, 88, 44, 76, 1
.word 54, 32, 21, 65, 87, 43, 29, 91, 17, 8
.word 6, 74, 50, 31, 19, 60, 81, 92, 13, 40
.word 27, 15, 72, 84, 9, 36, 58, 100, 4, 14
.word 95, 20, 41, 7, 66, 80, 30, 16, 73, 28
.word 59, 83, 97, 18, 62, 46, 25, 53, 71, 35
.word 94, 38, 48, 64, 70, 33, 82, 96, 24, 52
.word 61, 39, 68, 86, 26, 55, 79, 93, 37, 42
.word 47, 69, 63, 77, 98, 49, 75, 57, 85, 51


.text
.globl main

main:

    la   $gp, A
    li   $t0, 0
    lw   $t1, 0($gp)

    move $v0, $t1
    move $s0, $t1

    li   $v1, 0
    li   $s1, 0

    li   $t2, 0

loop:
    beq  $t0, 100, done

    sll  $t3, $t0, 2
    add  $t4, $gp, $t3
    lw   $t1, 0($t4)

    add  $t2, $t2, $t1

    slt  $t5, $v0, $t1
    beq  $t5, $zero, skipMax
    move $v0, $t1
    move $v1, $t0

skipMax:

    slt  $t6, $t1, $s0
    beq  $t6, $zero, skipMin
    move $s0, $t1
    move $s1, $t0

skipMin:

    addi $t0, $t0, 1
    j    loop

done:
    li   $t7, 100
    div  $t2, $t7
    mflo $s2

    li   $v0, 10
    syscall

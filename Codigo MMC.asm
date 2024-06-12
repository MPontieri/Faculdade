.data
num1: .asciiz "Digite o 1° número: "
num2: .asciiz "Digite o 2° número: "
num3: .asciiz "Digite o 3° número: "
resultado: .asciiz "O Mínimo Multiplo Comum dos três números é: "
ln: .asciiz "\n"

.text
.globl main

main:
    li $v0, 4
    la $a0, num1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 4
    la $a0, num2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    li $v0, 4
    la $a0, num3
    syscall

    li $v0, 5
    syscall
    move $t2, $v0

    move $a0, $t0
    move $a1, $t1
    jal mmc

    move $a0, $v0
    move $a1, $t2
    jal mmc

    move $t8, $v0

    li $v0, 4
    la $a0, resultado
    syscall

    move $a0, $t8
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, ln
    syscall

    li $v0, 10
    syscall

mmc:
    move $t3, $a0
    move $t4, $a1

    bge $t3, $t4, maior_igual
    move $t5, $t4
    move $t4, $t3
    move $t3, $t5

maior_igual:
    move $t5, $t3
    move $t6, $t4

mmc_loop:
    beq $t5, $t6, mmc_resultado  
    blt $t5, $t6, incremento
    add $t6, $t6, $t4
    j mmc_loop

incremento:
    add $t5, $t5, $t3
    j mmc_loop

mmc_resultado:
    move $v0, $t5
    jr $ra

.data 
	prompt: .asciiz "Enter N: "
	invalid: .asciiz "Input should be >= 0\n"
	message: .asciiz "Result: "
	space: " "
.text
main:
input:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0     #s0 = N
	
	slt $t0, $0, $s0 # 0 < N?
	bne $t0, $0, endInput # N > 0 -> loop
	
	li $v0, 4
	la $a0, invalid
	syscall
	j input
	
endInput:
	li $v0, 4
	la $a0, message
	syscall
	
	li $s1, 1  #i=1
loop:
	slt $t0, $s1, $s0 # i < N ?
	beq $t0, $0, endLoop # i >=N -> end loop
	
	li $s2, 3
	div $s1, $s2
	mfhi $t1
	li $s2, 5
	div $s1, $s2
	mfhi $t2
	
	beq $t1, $0, print
	beq $t2, $0 ,print
	 
	j continue
print:
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	j continue
continue:
	addi $s1, $s1, 1
	j loop
endLoop:
	li $v0, 10
	syscall
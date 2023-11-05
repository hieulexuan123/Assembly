.data
	prompt: .asciiz "Enter a positive integer N: "
	err: .asciiz "Invalid input!\n"
	message: .asciiz "Fibonacci numbers less than N: "
	space: .asciiz " "
.text
input:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0  #s0 = N
	
	slt $t0, $0, $s0 # 0 < N ?
	beq $t0, $0, input # N <= 0 -> input
fibonacci:
	li $v0, 4
	la $a0, message
	syscall
	
	li $s1, 0  # i = 0
	li $s2, 1  # j = 1
loop:
	slt $t0, $s2, $s0 # j < N ?
	beq $t0, $0, endLoop  # j >= N
	
	li $v0, 1
	move $a0, $s2 
	syscall      #print j
	
	li $v0, 4
	la $a0, space
	syscall
	
	move $s3, $s2  # s3 = temp = j
	add $s2, $s2, $s1  # j = j + i
	move $s1, $s3  # i = temp
	
	j loop
endLoop:
	li $v0, 10
	syscall
	 
	
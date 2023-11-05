.data
	promptM: .asciiz "Enter a positive integer M: "
	promptN: .asciiz "Enter a positive integer N (N>M): "
	err: .asciiz "Invalid input!\n"
	message: .asciiz "Prime numbers from M to N: "
	space: .asciiz " "
.text
inputM:
	li $v0, 4
	la $a0, promptM
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0  #s0 = M
	
	slt $t0, $0, $s0 # 0 < M ?
	beq $t0, $0, inputM # M <= 0 -> inputM
inputN:
	li $v0, 4
	la $a0, promptN
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0  #s1 = N
	
	slt $t0, $s0, $s1 # M < N ?
	beq $t0, $0, inputN # M >= N -> inputN
print:
	li $v0, 4
	la $a0, message
	syscall
	
	addi $s3, $s0, -1   #i = M-1
loopPrint:
	addi $s3, $s3, 1
	slt $t0, $s1, $s3  #N<i?
	bne $t0, $0, endMain  #N < i -> endMain
	
	move $a0, $s3
	jal checkPrime      #checkPrime(i)
	beq $v0, $0, loopPrint  #if not prime number -> loop
	
	li $v0, 1     
	syscall       #print prime number
	
	li $v0, 4
	la $a0, space
	syscall
	
	j loopPrint
endMain:
	li $v0, 10
	syscall
	

# Procedure checkPrime
# Input: $a0: n = number to check
# Output: $v0: 1 if is prime, 0 if not
checkPrime:
	addi $t0, $a0, -2 
	bltz $t0, isNotPrime      # n < 2 -> return 0
	
	li $s2, 2   # init i = 2
loopCheck:
	slt $t0, $s2, $a0 # i < n ?
	beq $t0, $0, isPrime  # i >= n -> prime number
	
	div $a0, $s2
	mfhi $t0  #t0 = n % i
	beq $t0, $0, isNotPrime
	
	addi $s2, $s2, 1
	
	j loopCheck
isPrime:
	li $v0, 1
	jr $ra
isNotPrime:
	li $v0, 0
	jr $ra

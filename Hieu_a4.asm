.data
	prompt: .asciiz "Enter positive integer: "
	invalid: .asciiz "Invalid input\n"
	message: .asciiz "Perfect numbers smaller than n: "
	space: .asciiz " "
.text
input:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0 #s0 = N
	
	slt $t0, $0, $s0  # 0 < N?
	beq $t0, $0, input # N <= 0 -> re input
printSequence:
	li $v0, 4
	la $a0, message
	syscall

	li $s1, 1  # i = 1
loopPrint:
	slt $t0, $s1, $s0  # i < N?
	beq $t0, $0, endMain #i >= N
	move $a0, $s1   
	jal checkPerfect  #checkPerfect(i)
	beq $v0, $0, continuePrint  # not perfect -> continue
	
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
continuePrint:
	addi $s1, $s1, 1
	j loopPrint
endMain:
	li $v0, 10
	syscall
	


#Function int checkPerfect(int n)
# $a0 = n, output = $v0 (1 if perfect, 0 if not)

checkPerfect:
	li $s2, 0      #sum = 0
	li $s3, 1      #i = 1
loopCheck:
	slt $t0, $s3, $a0    # i < n?
	beq $t0, $0, endLoopCheck
	div $a0, $s3   
	mfhi $t0    # t0 = n%i
	bne $t0, $0, continueLoopCheck  # t0 <> 0 -> continue
	add $s2, $s2, $s3   #sum+=i
continueLoopCheck:
	addi $s3, $s3, 1
	j loopCheck
endLoopCheck:
	beq $s2, $a0, isPerfect   #sum = n
isNotPerfect:
	li $v0, 0
	jr $ra
isPerfect:
	li $v0, 1
	jr $ra
	
	
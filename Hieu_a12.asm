.data
	A: .space 200
	prompt: .asciiz "Enter positive integer: "
	invalid: .asciiz "Invalid input\n"
	message: .asciiz "Octal representation: "
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
print:
	li $v0, 4
	la $a0, message
	syscall
	
	move $a0, $s0
	jal convertOctal
endMain:
	li $v0, 10
	syscall

#function void convertOctal(int n)
convertOctal:
	move $s1, $a0    # temp = n	
	la $s3, A        # starting address of A
	move $s2, $s3    # pointer = A
	li $s4, 8        # s4 = 8
loop1:
	beq $s1, $0, endLoop1
	div $s1, $s4
	mflo $s1 #temp = temp/8
	mfhi $s5 #s5 = temp%8
	
	sw $s5, 0($s2)
	
	addi $s2, $s2, 4 # pointer = pointer + 4
	j loop1	 
endLoop1:
loop2: #print in reverse order
	addi $s2, $s2, -4
	slt $t0, $s2, $s3  # pointer < A?
	bne $t0, $0, endLoop2 # pointer < A -> end loop 2
	
	lw $a0, 0($s2)
	li $v0, 1
	syscall
	
	j loop2
endLoop2:
	jr $ra

	
	
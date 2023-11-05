.data
	A: .space 100
	message1: .asciiz "Enter array size: "
	message2: .asciiz "Enter element "
	message3: .asciiz "Enter M: "
	message4: .asciiz "Enter N (N>M): "
	res1: .asciiz "Elements from M to N: "
	res2: .asciiz "Num of elements: "
	space: .asciiz " "
	colon: .asciiz ": "
.text
main:
	la $s1, A  #s1: pointer = base address
input_size:
	li $v0, 4
	la $a0, message1
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0   #s0: array size
	
	slt $t0, $0, $s0
	beq $t0, $0, input_size #size<=0 => re input
	
	li $s2, 0 # i = 0	
input_elements:
	beq $s2, $s0, input_M #i = size -> end input
	
	li $v0, 4
	la $a0, message2
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 4
	la $a0, colon
	syscall
	
	li $v0, 5
	syscall
	move $s3, $v0  #s3: curr element
	
	sw $s3, 0($s1) #A[i] = curr element
	addi $s1, $s1, 4
	addi $s2, $s2, 1
	
	j input_elements
input_M:
	li $v0, 4
	la $a0, message3
	syscall
	
	li $v0, 5
	syscall
	move $s4, $v0 #s4: M
input_N:
	li $v0, 4
	la $a0, message4
	syscall
	
	li $v0, 5
	syscall
	move $s5, $v0 #s5: N
	
	slt $t0, $s4, $s5 #M<N?
	beq $t0, $0, input_N #M>=N -> re input
print_feasible_elements:
	li $v0, 4
	la $a0, res1
	syscall
	
	la $s1, A  #s1: pointer
	li $s2, 0  #i = 0
	li $s6, 0  #count = 0
loop:
	beq $s2, $s0, end_loop  #i = size
	
	lw $s3, 0($s1)  #s3 = A[i]
	slt $t0, $s3, $s4  #A[i]<M?
	bne $t0, $0, continue #A[i]<M -> continue
	slt $t0, $s5, $s3  #N<A[i]?
	bne $t0, $0, continue #N<A[i] -> continue
	
	li $v0, 1
	move $a0, $s3
	syscall #print A[i]
	
	li $v0, 4
	la $a0, space
	syscall
	
	addi $s6, $s6, 1 #update count
continue:	
	addi $s2, $s2, 1
	addi $s1, $s1, 4
	
	j loop
end_loop:
	li $v0, 4
	la $a0, res2
	syscall
	
	li $v0, 1
	move $a0, $s6
	syscall
end_main:
	li $v0, 10
	syscall
.data
	str: .space 300
	message: .asciiz "Enter str: "
	res1: .asciiz "Symmetric"
	res2: .asciiz "Not symmetric"
.text
main:
input:
	li $v0, 4
	la $a0, message
	syscall
	
	li $v0, 8
	la $a0, str
	li $a1, 300
	syscall
end_input:
	li $s0, 0 #i=0
	la $s1, str # s1: left pointer
	la $s2, str # s2: right pointer
move_right:
	lb $s4, 0($s2)
	beq $s4, 10, end_move_right #str[i] = '\n'
	beq $s4, 0, end_move_right #str[i] = '\0'
	
	addi $s2, $s2, 1
	j move_right
end_move_right:
	addi $s2, $s2, -1
check:
	slt $t0, $s1, $s2 #left pointer < right pointer?
	beq $t0, $0, asym #left >= right -> asym
	
	lb $s3, 0($s1) #str[i]
	lb $s4, 0($s2) #str[j]
	bne $s3, $s4, not_asym
	
	addi $s1, $s1, 1
	addi $s2, $s2, -1
	j check
asym:
	li $v0, 4
	la $a0, res1
	syscall
	
	j end_check
not_asym:
	li $v0, 4
	la $a0, res2
	syscall
	
	j end_check
end_check:
	li $v0, 10
	syscall
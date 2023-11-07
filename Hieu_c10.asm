.data
	str1: .space 300
	str2: .space 300
	message1: .asciiz "Enter str1: "
	message2: .asciiz "Enter str2: "
	res1: .asciiz "Same"
	res2: .asciiz "Different"
.text
main:
input:
	li $v0, 4
	la $a0, message1
	syscall
	
	li $v0, 8
	la $a0, str1
	li $a1, 300
	syscall
	
	li $v0, 4
	la $a0, message2
	syscall
	
	li $v0, 8
	la $a0, str2
	li $a1, 300
	syscall
end_input:
	li $s0, 0 #i=0
	la $s1, str1 # s1: pointer of str1
	la $s2, str2 # s2: pointer of str2
# while (i<300)
#{
#	int check = str1[i] + str2[i];
#	if (check==0 || check==10 || check==20){
#		printf("Same");
#		break;
#	}
#	str1[i] = upper(str1[i]);
#	str2[i] = upper(str2[i]);
#	if (str1[i] != str2[i]){
#		printf("Different");
#		break;
#	}
#	i++;
#}
loop:
	beq $s0, 300, end_loop #i=300 -> end loop
	
	lb $s3, 0($s1) #s3: str1[i]
	lb $s4, 0($s2) #s4: str2[i]
	
	add $t0, $s3, $s4 #t0 = str1[i] + str2[i]
	beq $t0, 0, same
	beq $t0, 10, same
	beq $t0, 20, same
	
	move $a0, $s3
	jal upper
	move $s3, $v0 #str1[i] = upper(str1[i])
	
	move $a0, $s4
	jal upper
	move $s4, $v0 #str2[i] = upper(str2[i])
	
	bne $s3, $s4, different
	
	addi $s0, $s0, 1
	addi $s1, $s1, 1
	addi $s2, $s2, 1
	j loop
same:
	li $v0, 4
	la $a0, res1
	syscall
	
	j end_loop
different:
	li $v0, 4
	la $a0, res2
	syscall
	
	j end_loop
end_loop:
	li $v0, 10
	syscall

#char upper(char c){
#	if (c>=97 && c<=122) {
#		c = c-32;
#	}
#	return c;
#}

upper:
	addi $t0, $a0, -97
	bltz $t0, end_upper   #c<97
	
	addi $t0, $a0, -122
	bgtz $t0, end_upper #c>122
	
	addi $a0, $a0, -32
end_upper:
	move $v0, $a0
	jr $ra
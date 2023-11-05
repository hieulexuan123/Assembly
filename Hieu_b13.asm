.data
	A: .space 100
	unique: .space 100
	message1: .asciiz "Enter array size: "
	message2: .asciiz "Enter element "
	res: .asciiz "Num of unique elements: "
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
	beq $s2, $s0, count_unique #i = size -> end input
	
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
count_unique:
#C code 
#int res = 0;
#    int unique[5];
#    for (int i=0; i<size; i++){
#       int found = 0;
#        for (int j=0; j<res; j++){
#            if (unique[j] == arr[i]){
#                found = 1;
#               break;
#            }  
#        }
#        if (found==0) {
#            unique[res++] = arr[i];
#        }  
#    }
#    printf("Num of unique elements: %d", res);
	li $t1, 0 # res = 0
	la $s1, A # pointer of A
	li $s2, 0 # i = 0
outer_loop:
	beq $s2, $s0, end_outer_loop # i = size -> end_outer_loop
	
	lw $s3, 0($s1) #s3: arr[i]
	li $s4, 0 #found = 0
	la $t2, unique #pointer of unique array
	li $t3, 0 #j = 0
inner_loop:
	beq $t3, $t1, end_inner_loop #j = res -> end_inner_loop
	
	lw $t4, 0($t2) #t4: unique[j]
	beq $t4, $s3, modify_found #unique[j] = arr[i] -> modify found
	
	addi $t3, $t3, 1
	addi $t2, $t2, 4
	j inner_loop
modify_found:
	li $s4, 1
end_inner_loop:
	bne $s4, $0, continue #found = 1 ->  continue
	
	sw $s3, 0($t2) #unique[res] = arr[i]
	addi $t1, $t1, 1 # res++
continue:
	addi $s2, $s2, 1
	addi $s1, $s1, 4
	j outer_loop
end_outer_loop:
	li $v0, 4
	la $a0, res
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
end_main:
	li $v0, 10
	syscall
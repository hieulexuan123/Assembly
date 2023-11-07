.data
	str: .space 300
	shortest: .space 300
	message: .asciiz "Enter str: "
	res: .asciiz "Shortest word: "
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
	la $t1, shortest #base address of shortest
	li $t2, 1000 #shortest_size = 1000
	
	la $s0, str #base address of str
	li $s1, 0 #curr_size = 0
	li $s2, 0 # i = 0
loop:
	add $s3, $s0, $s2 #s3 = str +i
	lb $s4, 0($s3) # s4 = str[i]
	beq $s4, $0, end_loop # str[i] = '\0' -> end_loop 
	
	beq $s4, 32, update_shortest #str[i] = ' ' -> update_shortest
	beq $s4, 10, update_shortest #str[i] = '\n' -> update_shortest
	
	addi $s1, $s1, 1 # curr_size ++
	
	j continue
update_shortest:
	slt $t0, $s1, $t2 #curr_size < shortest_size?
	beq $t0, $0, reset #curr_size >= shortest_size
	
	move $t2, $s1 #shortest_size = curr_size
	move $a0, $t1
	sub $a1, $s3, $s1 #a1 = str + i - curr_size
	move $a2, $s1 
	jal copy 
reset:
	li $s1, 0 #curr_size = 0
continue:
	addi $s2, $s2, 1 #i++
	j loop
end_loop:
	add $t3, $t1, $t2 
	sb $0, 0($t3) #shortest[shortest_size] = '\0'
	
	li $v0, 4
	la $a0, res
	syscall
	
	li $v0, 4
	la $a0, shortest
	syscall
end_main:
	li $v0, 10
	syscall

#void copy(char* dest, char* src, int size){
#    for (int i=0; i<size; i++){
#        dest[i] = src[i];
#    }
#}

copy:
	li $t3, 0
copy_loop:
	beq $t3, $a2, end_copy #i = size -> end_copy
	
	lb $t4, 0($a1) #t4 = src[i]
	sb $t4, 0($a0) #dest[i] = src[i]
	
	addi $t3, $t3, 1
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	j copy_loop
end_copy:
	jr $ra
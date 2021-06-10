.data 
values: .word 1,1,2,1 #array contents
size: .word 3 # size of array
out_string: .asciiz "\nNo second smallest!\n"

.text

#min =arr[0]
#secondMin = 0
#for i in arr:
#	if arr[i]<min
#		secondMin = min   
#		min = arr[i]
#	else if secondMin==min
#			secondMin=arr[i]
#
#	else if(arr[i] < secondMin && arr[i] != min) 
#                secondMin = arr[i];
#if secondMin == min:
#	print(No second smallest)
#else
#	print(secondMin)			
		


lw $s0 size  
la $t0 values

addi $t2 $zero 0	#array index
lw $t1 0($t0)	#secondMin value
lw $s1 0($t0)	#min value

LOOP: beq $t2 $s0 EXIT2  
	sll $t4 $t2 2   # distance of the next elemetn from base adress => value of $t2*4
	add $t4 $t4 $t0 # adress of next element = 4(int = 4byte) + base adress($t0)
	lw $t3 0($t4)   # we get i th element of array load it into $t3 (i =0($t4)
	slt $s2, $t3, $s1 # if ($t3 < $s1): s2 =1
	beq $s2 $zero ELSE   
	add $t1 $zero $s1		#secondMiin = min
	add $s1 $zero $t3		#min = arr[i]	
	EXIT:	
	addi $t2 $t2 1	
	j LOOP
	 	
ELSE:
bne $t1 $s1 EXIT3  #if ($t1 == $s1)
add $t1 $zero $t3	#secondMiin = arr[i]
addi $t2 $t2 1 
j LOOP


EXIT3:
slt $s3, $t3, $t1 # if ($t3 < $t1)s3:1
beq $s3 $zero EXIT
beq $t3 $s1 EXIT
add $t1 $zero $t3	#secondMiin = arr[i]
addi $t2 $t2 1 
j LOOP


EXIT2:
beq $t1 $s1 L
li $v0, 1	#service 1 is print int with $v0 register
add $a0,$zero,$t1  # load desired value into argument register $a0, using psuedo-op
syscall
li $v0, 10
syscall


L:
li $v0, 4 # system call code for printing string = 4
la $a0, out_string # load address of string to be printed into $a0
syscall # call operating system to perform operation
# specified in $v0
# syscall takes its arguments from $a0, $a1, ...
li $v0, 10 # terminate program
syscall

	.data

PROMPT_MSG:
	.asciiz		"Enter a number: "
ERROR_MSG:
	.asciiz		"square too big for 32 bits\n"

	.text
SQUARE_MAX = 46340

# locals:
	# t0 is x
	# t1 is y
main:
	la 	$a0, PROMPT_MSG
	li 	$v0, 4
	syscall 				# printf("Enter a number: ");
	
	li	$v0, 5
	syscall					# scanf("%d", &x);
	
	move	$t0, $v0
	
	ble	$t0, SQUARE_MAX, x_le_max_val	# if (x <= SQUARE_MAX) goto x_le_max_val;
	
x_gt_max_val:
	la 	$a0, ERROR_MSG
	li 	$v0, 4
	syscall 				# printf("square too big for 32 bits\n");
	
	j 	epilogue
	
x_le_max_val:
	mul	$t1, $t0, $t0 			# y = x * x;
	
	move	$a0, $t1
	li	$v0, 1
	syscall 				# printf("%d", y);
	
	li	$a0, '\n'
	li	$v0, 11
	syscall 				# printf("\n");

epilogue:
	li	$v0, 0
	jr	$ra				# return 0
	
	
	.data

PROMPT_MSG:
	.asciiz		"Enter a number: "
MEDIUM_MSG:
	.asciiz		"medium\n"
SMALL_BIG_MSG:
	.asciiz		"small/big\n"

	.text

# locals:
	# t0 is x
main:
	la 	$a0, PROMPT_MSG
	li 	$v0, 4
	syscall 					# printf("Enter a number: ");
	
	li	$v0, 5
	syscall						# scanf("%d", &x);
	
	move	$t0, $v0
	
	ble	$t0, 100, x_le_100_ge_1000		# if (x <= 100) goto x_le_100_ge_1000;
	blt	$t0, 1000, x_le_100_ge_1000_false	# if (x >= 1000) goto x_le_100_ge_1000_false;
	
x_le_100_ge_1000:
	la 	$a0, SMALL_BIG_MSG
	li 	$v0, 4
	syscall 					# printf("small/big\n");
	
	j 	epilogue
	
x_le_100_ge_1000_false:
	la 	$a0, MEDIUM_MSG
	li 	$v0, 4
	syscall 					# printf("medium\n");
	
epilogue:
	li	$v0, 0
	jr	$ra					# return 0
	
	
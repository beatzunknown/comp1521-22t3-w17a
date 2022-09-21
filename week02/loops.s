# locals:
	# t0 is i
	# t1 is j
main:
loop_i_init:
	li 	$t0, 1			# int i = 1;
	
loop_i_cond:
	bgt 	$t0, 10, epilogue	#if (i > 10) goto epilogue;

loop_j_init:
	li 	$t1, 0			# int j = 0;

loop_j_cond:
	bge 	$t1, $t0, loop_j_end	# if (j >= i) goto loop_j_end;
	
	li 	$a0, '*'
	li 	$v0, 11
	syscall				# printf("*");

loop_j_step:
	addi 	$t1, $t1, 1		# j++
	
	j 	loop_j_cond
	
loop_j_end:
	li 	$a0, '\n'
	li 	$v0, 11
	syscall				# printf("\n");

loop_i_step:
	addi 	$t0, $t0, 1 		# i++;
	
	j 	loop_i_cond

epilogue:
	li	$v0, 0
	jr	$ra			# return 0
	
	
	.data

numbers:
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  # int numbers[10] = {0};

	.text
N_SIZE = 10

main:
# t0 is i
# t1 is &numbers[i]
# t2 is numbers[i]

main__scan_i_init:
	li 	$t0, 0				# int i = 0;
	la 	$t1, numbers 			# &numbers[0]
  
main__scan_i_cond:
	bge 	$t0, N_SIZE, main__scan_i_end 	# if (i >= 10) goto main__scan_i_end;
	
main__scan_i_body:
	li 	$v0, 5
	syscall					# scanf("%d", &numbers[i]);
	sw 	$v0, ($t1)

main__scan_i_step:
	addi 	$t0, $t0, 1 			# i++;
	addi 	$t1, $t1, 4 			# &numbers[i]

	j 	main__scan_i_cond

main__scan_i_end:
main__print_i_init:
	li 	$t0, 0 				# i = 0;

main__print_i_cond:
	bge 	$t0, N_SIZE, main__print_i_end 	# if (i >= 10) goto main__print_i_end;

main__print_i_body:
	mul	$t3, $t0, 4			# i * sizeof(int)
	lw 	$a0, numbers($t3) 		# numbers[i]
	li 	$v0, 1
	syscall 				# printf("%d", numbers[i]);
	
	li 	$a0, '\n'
	li 	$v0, 11
	syscall					# printf("\n")

main__print_i_step:
	addi 	$t0, $t0, 1 			# i++;
	
	j 	main__print_i_cond


main__print_i_end:
	li	$v0, 0
	jr	$ra				# return 0
    
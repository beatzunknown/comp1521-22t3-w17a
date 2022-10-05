	.data

flag:
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'

	.text
FLAG_ROWS = 6
FLAG_COLS = 12
	
# 2d array offset is:
# (index of first dimension) * (size of 2nd dimension) + (index of 2nd dimension)

# t0 is row
# t1 is col
# t2 is (row*12 + col)
# t3 is &flag[row][col]
main:

main__row_init:
	li 	$t0, 0 				# int row = 0

main__row_cond:
	bge 	$t0, FLAG_ROWS, main__row_end 	# if (row < FLAG_ROWS)

main__col_init:
	li 	$t1, 0 				# int col = 0

main__col_cond:
	bge 	$t1, FLAG_COLS, main__col_end 	# if (col < FLAG_COLS)

main__col_body:
	mul 	$t2, $t0, FLAG_COLS		# (row*12)
	add 	$t2, $t2, $t1 			# (row*12 + col)
	la 	$t3, flag 			# flag
	add 	$t3, $t3, $t2 			# &flag[row][col]
	
	lb 	$a0, ($t3)			# flag[row][col]
	# lb 	$a0, flag($t2)
	li 	$v0, 11
	syscall 				# printf ("%c", flag[row][col]);

main__col_step:
	addi 	$t1, $t1, 1 			# col++;
	j 	main__col_cond

main__col_end:
	li 	$a0, '\n' 			# # printf ("\n");
	syscall
	
main__row_step:
	addi 	$t0, $t0, 1			# row++

	j 	main__row_cond

main__row_end:
	li	$v0, 0
	jr	$ra				# return 0

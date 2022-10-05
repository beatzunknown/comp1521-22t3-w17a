	.data

M:
	.word 1, 2, 3, 4
	.word 3, 4, 5, 6
	.word 5, 6, 7, 8

	.text
	
main:
# Args:
# 	- void
# Returns:
#	- $v0: int
#
# Frame:	[$ra]
# Uses:		[$v0, $a0, $a1, $a2, $a3]
# Clobbers:	[$a0, $a1, $a2, $a3]
#
# Locals:
#	- [...]
#
# Structure:
#	main
#	-> [prologue]
#	-> main__body
#	-> [epilogue]

main__prologue:
	begin		# create stack frame
	push	$ra	# save $ra
	
main__body:
	li	$a0, 3
	li	$a1, 4
	la	$a2, M
	li	$a3, 2
	jal	change	# change(3, 4, M, 2);
	
main__epilogue:
	pop	$ra	# restore $ra
	end		# destroy stack frame
	
	li	$v0, 0
	jr	$ra	# return 0
	
change:
# Args:
#	- int nrows
#	- int ncols
#	- int M[nrows][ncols]
#	- int factor
# Returns:
#	- void
#
# Frame:	[$ra, $s0, $s1]
# Uses:		[$a0, $a1, $a2, $a3, $s0, $s1, $t0, $t1]
# Clobbers:	[$t0, $t1]
#
# Locals:
#	- 'row' in $s0
#	- 'col' in $s1
#
# Structure:
#	change
#	-> [prologue]
#	-> change__body
#	-> change__row_cond
#	-> change__row_body
#		-> change__col_cond
#		-> change__col_body
#		-> change__col_f
#	-> change__row_f
#	-> [epilogue]

change__prologue:
	begin					# create stack frame
	push	$ra				# save $ra
	push	$s0				# save $s0
	push	$s1				# save $s1

change__body:
	li	$s0, 0				# int row = 0;
	
change__row_cond:
	bge	$s0, $a0, change__row_end	# if (row < nrows)

change__row_body:
	li	$s1, 0				# int col = 0;
	
change__col_cond:
	bge	$s1, $a1, change__col_end	# if (col < ncols)
	
change__col_body:
	mul	$t0, $s0, $a1			# row * ncols
	add	$t0, $t0, $s1			# (row * ncols) + col
	mul	$t0, $t0, 4			# (row*ncols + col) * sizeof(int)
	add	$t0, $t0, $a2			# &M[row][col]
	lw	$t1, ($t0)			# M[row][col]
	
	mul	$t1, $t1, $a3			# factor * M[row][col];
	sw	$t1, ($t0)			# M[row][col] = factor * M[row][col];
	
	addi	$s1, $s1, 1			# col++;
	j	change__col_cond

change__col_end:
	addi	$s0, $s0, 1			# row++;
	j	change__row_cond

change__row_end:
change__epilogue:
	pop	$s1				# restore $s1
	pop	$s0				# restore $s0
	pop	$ra				# restore $ra
	end
	
	jr	$ra				# return void
    
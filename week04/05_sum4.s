main:
# Args:
#	- void
# Returns:
#	- $v0: int
#
# Frame:	[$ra]
# Uses:		[$v0, $a0, $a1, $a2, $a3]
# Clobbers:	[$v0, $a0, $a1, $a2, $a3]
#
# Locals:
#	- [...]
#
# Structure:
#	main
#	-> [prologue]
#	-> body
#	-> [epilogue]

main__prologue:
	begin			# create stack frame
	push	$ra		# save $ra
	
main__body:
	li	$a0, 11
	li	$a1, 13
	li	$a2, 17
	li	$a3, 19
	jal	sum4		# sum4(11, 13, 17, 19);
	
	move	$a0, $v0
	li	$v0, 1
	syscall			# printf("%d", z);
	
	li	$a0, '\n'
	li	$v0, 11
	syscall			# printf("%c", '\n');
	
main__epilogue:
	pop	$ra		# restore $ra
	end			# destroy stack frame
	
	li	$v0, 0
	jr	$ra		# return 0
	
sum4:
# Args:
# 	- int a
# 	- int b
# 	- int c
# 	- int d
# Returns:
#	- int
#
# Frame:	[$ra, $s0, $s1, $s2, $s3, $s4]
# Uses:		[$v0, $a0, $a1, $a2, $a3, $s0, $s1, $s2, $s3, $s4]
# Clobbers:	[$a0, $a1]
#
# Locals:
#	- 'a' in $s0 from $a0
#	- 'b' in $s1 from $a1
#	- 'c' in $s2 from $a2
#	- 'd' in $s3 from $a3
#	- 'e' in $s4
#
# Structure:
#	sum4
#	-> [prologue]
#	-> sum4__body
#	-> [epilogue]

sum4__prologue:
	begin			# create stack frame
	push	$ra		# save $ra
	push	$s0		# save $s0
	push	$s1		# save $s1
	push	$s2		# save $s2
	push	$s3		# save $s3
	push	$s4		# save $s4
	
	# optionally save ALL arguments to $s registers
	move	$s0, $a0
	move	$s1, $a1
	move	$s2, $a2
	move	$s3, $a3

sum4__body:
	jal	sum2		# sum2(a, b);
	move	$s4, $v0	# int e = sum2(a, b);
	
	move	$a0, $s2
	move	$a1, $s3
	jal	sum2		# int f = sum2(c, d);
	
	move	$a0, $s4
	move	$a1, $v0
	jal	sum2		# sum2(e, f);
	
sum4__epilogue:
	pop	$s4		# restore $s4
	pop	$s3		# restore $s3
	pop	$s2		# restore $s2
	pop	$s1		# restore $s1
	pop	$s0		# restore $s0
	pop	$ra		# restore $ra
	end			# destroy stack frame
	
	jr	$ra		# return sum2(e, f);
	
sum2:
# Args:
# 	- int x
# 	- int y
# Returns:
#	- int
#
# Frame:	[...]
# Uses:		[$v0, $a0, $a1]
# Clobbers:	[...]
#
# Locals:
#	- body
#
# Structure:
#	sum2

sum2__body:
	# no need for stack frame
	add	$v0, $a0, $a1
	jr	$ra		# return x + y;
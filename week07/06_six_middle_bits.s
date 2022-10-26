	.data
prompt:
	.asciiz "Get 6 middle bits of: "

	.text

main:
# Args:
# 	- void
# Returns:
#	- $v0: int
#
# Frame:	[$ra]
# Uses:		[$v0, $a0]
# Clobbers:	[$v0, $a0]
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
	begin			# create stack frame
	push	$ra		# save $ra
	
main__body:
	la 	$a0, prompt
	li 	$v0, 4
	syscall 		# printf("Get 6 middle bits of: ");

	li 	$v0, 5
	syscall 		# scanf("%d", &x);
	
	move 	$a0, $v0
	jal  	six_middle_bits	# six_middle_bits(x)

	move 	$a0, $v0
	li 	$v0, 1
	syscall 		# printf("%d", six_middle_bits(x));

	li 	$a0, '\n'
	li 	$v0, 11
	syscall 		# printf("\n");
	
main__epilogue:
	pop	$ra		# restore $ra
	end			# destroy stack frame
	
	li	$v0, 0
	jr	$ra		# return 0


six_middle_bits:
# Args:
# 	- uint32_t u
# Returns:
#	- $v0: int
#
# Frame:	[]
# Uses:		[$v0, $t0]
# Clobbers:	[$v0, $t0]
#
# Locals:
#	- 'u' in $a0
#
# Structure:
#	six_middle_bits
#	-> [prologue]
#	-> six_middle_bits__body
#	-> [epilogue]

six_middle_bits__prologue:
	
six_middle_bits__body:
	srl 	$t0, $a0, 13 	# u >> 13
	andi 	$t0, $t0, 0x3F 	# (u >> 13) & 0x3F;

six_middle_bits__epilogue:
	move 	$v0, $t0
	jr	$ra		# return return (u >> 13) & 0x3F;

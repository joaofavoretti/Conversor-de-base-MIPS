li 	$v0, 5
	syscall
	
	la	$t0, entrada_dec
	sw	$v0, 0($t0)
	
	la	$a0, entrada_dec
	la	$a1, saida_hex
	la	$a2, hexa_char
	
	jal decimalToHexadecimal
	
	# Print "\n"
	li	$v0, 4
	la	$a0, pulo_linha
	syscall
	
	# Print Hexa string
	li	$v0, 4
	la	$a0, saida_hex
	syscall
	
	# Exit
	li 	$v0, 10
	syscall
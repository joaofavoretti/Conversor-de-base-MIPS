# Read binary
	li 	$v0, 8
	la	$a0, entrada_bin
	li	$a1, 33
	syscall
	
	# binary to decimal
	la	$a0, entrada_bin
	la	$a1, saida_dec
	jal 	binaryToDecimal
	
	la	$a0, saida_dec
	la	$a1, saida_hex
	la	$a2, hexa_order
	jal 	decimalToHexadecimal
	
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
# Read binary
	li 	$v0, 8
	la	$a0, entrada_bin
	li	$a1, 32
	syscall
	
	# binary to decimal
	la	$a0, entrada_bin
	la	$a1, saida_dec
	jal 	binaryToDecimal
	
	# Print "\n"
	li	$v0, 4
	la	$a0, pulo_linha
	syscall
	
	# Print integer
	la	$t0, saida_dec
	lw	$a0, 0($t0)
	li 	$v0, 1
	syscall
	
	# Exit
	li 	$v0, 10
	syscall

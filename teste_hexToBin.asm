li 	$v0, 8
	la	$a0, entrada_hex
	li	$a1, 9
	syscall
	
	# Print "\n"
	li	$v0, 4
	la	$a0, pulo_linha
	syscall
	
	la	$a0, entrada_hex
	la	$a1, saida_bin
	la	$a2, hexa_order
	la	$a3, binario_order
	jal 	hexadecimalToBinario
	
	la	$a0, saida_bin
	la	$a1, saida_dec
	jal	binaryToDecimal
	
	# Print Hexa string
	li	$v0, 4
	la	$a0, saida_bin
	syscall
	
	# Exit
	li 	$v0, 10
	syscall
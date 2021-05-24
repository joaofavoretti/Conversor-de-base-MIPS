li	$v0, 12			# syscall 12 -> read char
	syscall				# LEITURA BASE DE ENTRADA
	la	$t0, base_entrada
	sw	$v0, 0($t0)		# base_entrada[0] = char
	# Print "\n"
	li	$v0, 4
	la	$a0, pulo_linha
	syscall
	
	la	$t0, base_entrada	# $t0 (&base_entrada)
	lw	$s0, 0($t0)		# $s0 (base_entrada[0])
	
	bne	$s0, 66, A0		# if base_entrada[0] != 'B' (66) then A0
	# ENTRADA BINARIO
	
		# LEITURA STRING BINARIO (Ex: 00000000000000000000000011001000)
		li 	$v0, 8
		la	$a0, entrada_bin
		li	$a1, 32
		syscall
		# Print "\n"
		li	$v0, 4
		la	$a0, pulo_linha
		syscall		
	
		# LEITURA BASE SAIDA
		li	$v0, 12			# syscall 12 -> read char
		syscall	
		la	$t0, base_saida
		sw	$v0, 0($t0)		# base_saida[0] = char
		# Print "\n"
		li	$v0, 4
		la	$a0, pulo_linha
		syscall		
	
		la	$t0, base_saida		# $t0 (&base_saida)
		lw	$s1, 0($t0)		# $s0 (base_saida[0])
	
		bne	$s1, 68, B0		# if base_saida[0] != 'D' (68) then B0
		# BINARIO -> DECIMAL
		
		la	$a0, entrada_bin
		la	$a1, saida_dec
		jal 	binaryToDecimal
		
		j 	A2			# JUMP IMPRESSAO
		
		B0:
		bne 	$s1, 72, A2		# if base_saida[0] != 'H' (72) then B0
		# BINARIO -> HEXADECIMAL
		
		la	$a0, entrada_bin	# BINARIO -> DECIMAL
		la	$a1, entrada_dec
		jal	binaryToDecimal
		
		la	$a0, entrada_dec	# DECIMAL -> HEXADECIMAL
		la	$a1, saida_hex
		la	$a2, hexa_order
		jal	decimalToHexadecimal
		
		j	A2			# JUMP IMPRESSAO
	
	
	A0:
	bne	$s0, 68, A1		# if base_entrada[0] != 'D' (68) then A1
	# ENTRADA DECIMAL
	
		# LEITURA WORD DECIMAL (Ex: 200)
		li 	$v0, 5
		la	$a0, entrada_dec
		syscall	
		# Print "\n"
		li	$v0, 4
		la	$a0, pulo_linha
		syscall	
	
		# LEITURA BASE SAIDA
		li	$v0, 12			# syscall 12 -> read char
		syscall				
		la	$t0, base_saida
		sw	$v0, 0($t0)		# base_saida[0] = char
		# Print "\n"
		li	$v0, 4
		la	$a0, pulo_linha
		syscall	
	
		la	$t0, base_saida		# $t0 (&base_saida)
		lw	$s1, 0($t0)		# $s0 (base_saida[0])
		
		bne	$s1, 66, B1		# if base_saida[0] != 'B' (66) then B1
		# DECIMAL -> BINARIO
		la	$a0, entrada_dec	# DECIMAL -> HEXADECIMAL
		la	$a1, entrada_hex
		la	$a2, hexa_order
		jal 	decimalToHexadecimal
		
		la	$a0, entrada_hex	# HEXADECIMAL -> BINARIO
		la	$a1, saida_bin
		la	$a2, hexa_order
		la	$a3, binario_order
		jal	hexadecimalToBinario
		
		j 	A2
		
		B1:
		bne	$s1, 72, A2		# if base_saida[0] != 'H' (72) then A2
		# DECIMAL -> HEXADECIMAL
		la	$a0, entrada_dec	# DECIMAL -> HEXADECIMAL
		la	$a1, saida_hex
		la	$a2, hexa_order
		jal 	decimalToHexadecimal
		
		
		
	A1:
	bne 	$s0, 72, A2		# if base_entrada[0] != 'H' (72) then A2
	# ENTRADA HEXADECIMAL
		
		# LEITURA STRING HEXADECIMAL (Ex: 000000c8)
		li 	$v0, 8
		la	$a0, entrada_hex
		li	$a1, 8
		syscall	
		# Print "\n"
		li	$v0, 4
		la	$a0, pulo_linha
		syscall	
		
		# LEITURA BASE SAIDA
		li	$v0, 12			# syscall 12 -> read char
		syscall	
		la	$t0, base_saida
		sw	$v0, 0($t0)		# base_saida[0] = char
		# Print "\n"
		li	$v0, 4
		la	$a0, pulo_linha
		syscall	
		
		la	$t0, base_saida		# $t0 (&base_saida)
		lw	$s1, 0($t0)		# $s0 (base_saida[0])
		
		bne	$s1, 66, B2		# if base_saida[0] != 'B' (66) then B2
		# HEXADECIMAL -> BINARIO
		la	$a0, entrada_hex	# HEXADECIMAL -> BINARIO
		la	$a1, saida_bin
		la	$a2, hexa_order
		la	$a3, binario_order
		jal	hexadecimalToBinario
		
		j	A2
		
		B2:
		bne	$s1, 68, A2		# if base_saida[0] != 'D' (68) then A2
		# HEXADECIMAL -> DECIMAL
		la	$a0, entrada_hex	# HEXADECIMAL -> BINARIO
		la	$a1, entrada_bin
		la	$a2, hexa_order
		la	$a3, binario_order
		jal	hexadecimalToBinario
		
		la	$a0, entrada_bin	# BINARIO -> DECIMAL
		la	$a1, saida_dec
		jal	binaryToDecimal


	
	# IMPRESSAO DOS VALORES
	A2:
	# Print "\n"
	li	$v0, 4
	la	$a0, pulo_linha
	syscall
	
	## IMPRESSAO VALORES ENTRADA_*
	li	$v0, 1
	la	$a0, entrada_dec
	syscall
	# Print "\n"
	li	$v0, 4
	la	$a0, pulo_linha
	syscall
	
	li	$v0, 4
	la	$a0, entrada_bin
	syscall
	# Print "\n"
	li	$v0, 4
	la	$a0, pulo_linha
	syscall
	
	li	$v0, 4
	la	$a0, entrada_hex
	syscall
	# Print "\n"
	li	$v0, 4
	la	$a0, pulo_linha
	syscall
	
	## IMPRSSAO VALORES SAIDA_*
	li	$v0, 1
	la	$a0, saida_dec
	syscall
	# Print "\n"
	li	$v0, 4
	la	$a0, pulo_linha
	syscall
	
	li	$v0, 4
	la	$a0, saida_bin
	syscall
	# Print "\n"
	li	$v0, 4
	la	$a0, pulo_linha
	syscall
	
	li	$v0, 4
	la	$a0, saida_hex
	syscall
	# Print "\n"
	li	$v0, 4
	la	$a0, pulo_linha
	syscall
	
	
	# Exit
	li 	$v0, 10
	syscall
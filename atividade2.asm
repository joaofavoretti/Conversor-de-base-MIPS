# Atividade 2 - Organizacao e Arquitetura de Computadores
# 
# Nomes dos alunos:
# João Pedro Favoretti (11316055)
# Lucas Pilla ()
# ====================
# TABELA DE PROCEDIMENTOS:
# 
# potencia: Retorna a $a0 elevado a $a1
# binaryToDecimal: $a0: endereco para .space 33 bytes (binario); $a1: endereco para .word (decimal)
# decimalToHexadecimal: $a0: endereco para .word (decimal); $a1: endereco para .space 9 (hexadecimal)
# hexadecimalToBinary: $a0: endereco para .space 9 (hexadecimal); $a1: endereco para .space 33 (binario)
# ====================
# NOMENCLATURA DE LABELS:
# 
# Label para indicar loops dentro de procedimentos tem nomeclaturas Lx
# ====================


## SEGMENTO DE DATA
.data
	.align 	2			# Alinhar variaveis à word
	entrada_dec:	.word 0		# Variavel para entrada de numero decimal
	entrada_hex:	.space 16	# Variavel para entrada de numero hexadecimal
	entrada_bin:	.space 64	# Variavel para entrada de numero binario
	base_entrada:	.space 2	# Espaco para armazenar a base da entrada
	
	saida_dec:	.word 0		# Variavel para saida de numero decimal
	saida_hex:	.space 16	# Variavel para saida de numero hexadecimal
	saida_bin:	.space 64	# Variavel para saida de numero binario
	base_saida:	.space 2	# Espaco para armazenar a base da saida

## SEGMENTO DE CÓDIGO
.text
.globl main
main:
	
	la	$a0, endrada_bin
	la	$a1, saida_dec
	jal binaryToDec

	# Print integer
	move $a0, $v0
	li $v0, 1
	syscall
	
	# Exit
	li $v0, 10
	syscall

## PROCEDIMENTOS ##

potencia:				## POTENCIA PROCEDURE ##
					# $a0 -> base
					# $a1 -> exp
					# return $v0: int
					#
					# STACK
					# +----------+
					# | $a0(base)| + 12
					# | $a1(exp) | + 8
					# | pot      | + 4
					# | i        | + 0
					# +----------+ $sp
	addi	$sp, $sp, -16

	sw	$a0, 12($sp)		# Save arguments
	sw	$a1, 8($sp)

	li 	$v0, 1			# $v0(pot) = 1
	sw	$v0, 4($sp)
	li 	$v1, 0			# $v1(i) = 0
	sw	$v1, 0($sp)

	$L1:
	lw	$v0, 0($sp)		# $v0 (i)
	lw	$v1, 8($sp)		# $v1(exp)
	bge	$v0, $v1, $E_L1		# if i >= exp then $E_L1
	
	lw	$v0, 4($sp)		# $v0 (pot)
	lw	$v1, 12($sp)		# $v1 (base)
	mult	$v0, $v1		# pot = pot * base
	mflo	$v0
	sw	$v0, 4($sp)
	
	lw	$v0, 0($sp)		# $v0 (i)
	addi	$v0, $v0, 1		# i = i + 1
	sw	$v0, 0($sp)

	j	$L1			# jump to L1

	$E_L1:
	lw	$v0, 4($sp)
	lw	$a0, 12($sp)
	lw	$a1, 8($sp)
	addi	$sp, $sp, 16
	jr 	$ra			# Retorna com resultado em $v0

binaryToDecimal:			## BINARY TO DECIMAL PROCEDURE ##
					# $a0: endereco para .space 33 bytes (binario)
					# $a1: endereco para .word (decimal)
					# return void
					#
					# STACK
					# +----------+
					# | $a0      | + 8
					# | $a1      | + 4
					# | i        | + 0
					# +----------+ $sp
	addi	$sp, $sp, -12

	sw	$a0, 8($sp)		# Save arguments
	sw	$a1, 4($sp)		
	
	
		

		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
					
					
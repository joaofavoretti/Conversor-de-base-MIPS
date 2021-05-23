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
# HexadecimalToBinary: $a0: endereco para .space 9 (hexadecimal); $a1: endereco para .space 33 (binario)
# ====================
# NOMENCLATURA DE LABELS:
# 
# Label para indicar loops dentro de procedimentos tem nomeclaturas Lx
# ====================


## SEGMENTO DE DATA
.data
	.align 	2			# Alinhar variaveis à word
	entrada_dec:	.word 0		# Variavel para entrada de numero decimal
	entrada_hex:	.space 9	# Variavel para entrada de numero hexadecimal
	entrada_bin:	.space 33	# Variavel para entrada de numero binario
	base_entrada:	.space 2	# Espaco para armazenar a base da entrada
	
	saida_dec:	.word 0		# Variavel para saida de numero decimal
	saida_hex:	.space 9	# Variavel para saida de numero hexadecimal
	saida_bin:	.space 33	# Variavel para saida de numero binario
	base_saida:	.space 2	# Espaco para armazenar a base da saida

## SEGMENTO DE CÓDIGO
.text
.globl main
main:
	li $a0, 2
	li $a1, 12
	jal potencia
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall

## PROCEDIMENTOS ##

potencia:				## POTENCIA PROCEDURE ##
					# $a0 -> base
					# $a1 -> expoente
					# return $v0: decimal
					# Ex: a^b ($a0: a, $a1:b)

	move 	$t0, $a0		# $t0(base)
	move 	$t1, $a1		# $t1(exp)
	li 	$v0, 1			# $v0(pot) = 1
	li 	$v1, 0			# $v1(i) = 0

	$L1:
	bge	$v1, $t1, $E_L1		# if $v1(i) >= $t1(exp) then $E_L1
	mult	$v0, $t0		# $v0 = $v0(pot)*$t0(base)
	mflo	$v0			#
	addi	$v1, $v1, 1		# $v1(i) = $v1(i) + 1
	j	$L1			# jump to L1

	$E_L1:
	jr 	$ra			# Retorna com resultado em $v0


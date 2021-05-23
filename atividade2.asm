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
	
	pulo_linha:	.asciiz	"\n"

## SEGMENTO DE CÓDIGO
.text
.globl main
main:
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
	addi	$sp, $sp, -16		# Alloc stack

	sw	$a0, 12($sp)		# Save arguments
	sw	$a1, 8($sp)		# Save arguments

	li 	$v0, 1			# pot = 1
	sw	$v0, 4($sp)		# pot = 1
	li 	$v1, 0			# i = 0
	sw	$v1, 0($sp)		# i = 0

	L1:
	lw	$v0, 0($sp)		# $v0 (i)
	lw	$v1, 8($sp)		# $v1 (exp)
	bge	$v0, $v1, E_L1		# if i >= exp then $E_L1
	
	lw	$v0, 4($sp)		# $v0 (pot)
	lw	$v1, 12($sp)		# $v1 (base)
	mult	$v0, $v1		# pot = pot * base
	mflo	$v0			# pot = pot * base
	sw	$v0, 4($sp)		# pot = pot * base
	
	lw	$v0, 0($sp)		# $v0 (i)
	addi	$v0, $v0, 1		# i = i + 1
	sw	$v0, 0($sp)		# i = i + 1

	j	L1			# jump to L1

	E_L1:
	lw	$v0, 4($sp)		# $v0 (pot)
	lw	$a0, 12($sp)		# Restore arguments
	lw	$a1, 8($sp)		# Restore arguments

	addi	$sp, $sp, 16		# Dealloc stack

	jr 	$ra			# Retorna com resultado em $v0


binaryToDecimal:			## BINARY TO DECIMAL PROCEDURE ##
					# $a0: endereco para .space 33 bytes (binario)
					# $a1: endereco para .word (decimal)
					# return void
					#
					# Based code
                    			# void binaryToDecimal(char *bin, int *dec) {
                    			#     *dec = 0;
                    			#    
                    			#     for (int i = 0; i < 32; i++) {
                    			#         if (bin[i] == '1')
                    			#             *dec = *dec + potencia(2, 31 - i);
                    			#     }
                    			# } 
					# 
					# STACK
					# +-----------+
					# | $s0       | + 12
					# | $a0(&bin) | + 8
					# | $a1(&dec) | + 4
					# | i         | + 0
					# +-----------+ $sp

	addi	$sp, $sp, -16		# Alloc stack
	
	sw	$s0, 12($sp)		# Save $s0 usado durante o procedimento
	
	sw	$a0, 8($sp)		# Save arguments
	sw	$a1, 4($sp)		# Save arguments
	
	lw	$t0, 4($sp)		# $t0 (&dec)
	li	$t1, 0			# *dec = 0
	sw	$t1, 0($t0)		# *dec = 0
	
	li	$t0, 0			# i = 0
	sw	$t0, 0($sp)		# i = 0
	
	L2: 	# for (int i = 0; i < 32; i++)
	lw	$t0, 0($sp)		# $t0 (i)
	bge	$t0, 32, E_L2		# if i >= 32 then E_L2
	
	 				# if (bin[i] == '1')
	lw	$t0, 8($sp)		# $t0 (&bin[0])
	lw	$t1, 0($sp)		# $t1 (i)
	addu	$t0, $t0, $t1		# $to (&bin[i])
	lb	$t2, 0($t0)		# $t2 (bin[i])
	li	$t0, 49			# $t0 ('1')
	bne 	$t0, $t2, L3		# bin[i] != '1' then L3
	
	lw 	$t0, 4($sp)		# $t0 (&dec)
	lw	$s0, 0($t0)		# $s0 (dec)
	
	li	$t0, 31			# $t0 (31)
	lw	$t1, 0($sp)		# $t1 (i)
	sub 	$t0, $t0, $t1		# $t0 (31 - i)
	
	li	$a0, 2			# Parametro base: 2
	move 	$a1, $t0		# Parametro expoente: 31 - i
	
	addi	$sp, $sp, -4		# Store RA
	sw	$ra, 0($sp)
	jal potencia			# potencia (2, 31 - i)
	lw	$ra, 0($sp)		# Load RA
	addi	$sp, $sp, 4
	
	lw	$t0, 4($sp)		# $t0 (&dec)
	addu	$s0, $s0, $v0		# dec = dec + potencia (2, 31 - i)
	sw	$s0, 0($t0)		# dec = dec + potencia (2, 31 - i)
	
	L3:	# End loop
	lw	$t0, 0($sp)		# $t0 (i)
	addi	$t0, $t0, 1		# i = i + 1
	sw	$t0, 0($sp)		# i = i + 1
	j 	L2

	E_L2: 	# End procedure
	
	lw	$s0, 12($sp)		# Load $s0
	lw	$a0, 8($sp)		# Load arguments
	lw	$a1, 4($sp)		# Load arguments
	
	addi	$sp, $sp, 16		# Dealloc Stack
	
	jr	$ra
	
	
	
		

		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
					
					
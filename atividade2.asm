# Atividade 2 - Organizacao e Arquitetura de Computadores
# 
# Nomes dos alunos:
# João Pedro Favoretti (Nusp: 11316055)
# Lucas Pilla Pimentel (Nusp: 10633328)
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
	.align 	2								# Alinhar variaveis à word
	entrada_dec:	.word 0							# Variavel para entrada de numero decimal
	.align 	2
	entrada_hex:	.ascii "0000000c8\0"					# Variavel para entrada de numero hexadecimal
	.align 	2
	entrada_bin:	.ascii "00000000000000000000000000000000\0"	# Variavel para entrada de numero binario
	.align 	2
	base_entrada:	.space 2						# Espaco para armazenar a base da entrada
	
	.align 	2
	saida_dec:	.word 0							# Variavel para saida de numero decimal
	.align 	2
	saida_hex:	.ascii "00000000\0"					# Variavel para saida de numero hexadecimal
	.align 	2
	saida_bin:	.ascii "00000000000000000000000000000000\0"	# Variavel para saida de numero binario
	.align 	2
	base_saida:	.space 2						# Espaco para armazenar a base da saida
	
	.align 2
	hexa_order:	.asciiz "0123456789abcdef"				# Caracteres Hexadecimais
	.align 2
	binario_order:	.asciiz "0000000100100011010001010110011110001001101010111100110111101111"
				# 0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111
	.align 	2
	pulo_linha:	.asciiz	"\n"

## SEGMENTO DE CÓDIGO
.text
.globl main
main:
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
					# 
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


decimalToHexadecimal:			## DECIMAL TO HEXADECIMAL PROCEDURE ##
					# $a0: endereco para .word (decimal)
					# $a1: endereco para .space 9 bytes (hexadecimal)
					# $a2: endereco para .asciiz com caracteres hexadecimais
					# return void
					#
					# Based code
					# void decimalToHexa(int *dec, char *hexa, char *charHexa) {
					#     int i, j, k;
					#     for (j = 8, i = *dec; i != 0; i = i / 16, j--) {
					#         k = i % 16;
					#         hexa[j] = charHexa[k];
					#     }
					# }
					# 
					# STACK
					# +-----------+
					# | $a0(&dec) | + 20
					# | $a1(&hex) | + 16
					# | $a2(&hxc) | + 12
					# | i         | + 8
					# | j         | + 4
					# | k         | + 0
					# +-----------+ $sp
	
	addi	$sp, $sp, -24		# Alloc stack
	
	sw	$a0, 20($sp)		# Save arguments
	sw	$a1, 16($sp)		# Save arguments
	sw	$a2, 12($sp)		# Save arguments
	
	li 	$t0, 8			# j = 8
	sw	$t0, 4($sp)		# j = 8

	lw	$t0, 20($sp)		# $t0 (&dec)
	lw	$t1, 0($t0)		# $t1 (dec)
	sw	$t1, 8($sp)		# i = dec
	
	L4:
	lw	$t0, 8($sp)		# $to (i)
	beq	$t0, $zero, E_L4	# if i == 0 then E_L4
	
	lw	$t0, 8($sp)		# $t0 (i)
	rem 	$t1, $t0, 16		# k = i % 16
	sw	$t1, 0($sp)		# k = i % 16
	
	lw	$t0, 16($sp)		# $t0 (&hex)
	lw	$t1, 4($sp)		# $t1 (j)
	addu	$t0, $t0, $t1		# $t0 (&hex[i])
	
	lw	$t1, 12($sp)		# $t1 (&hxc)
	lw	$t2, 0($sp)		# $t2 (k)
	addu	$t1, $t1, $t2		# $t1 (&hxc[k])
	
	lb	$t2, 0($t1)		# hex[i] = hxc[k]
	sb	$t2, 0($t0)		# hex[i] = hxc[k]
	
	lw	$t0, 8($sp)		# $t0 (i)
	div	$t0, $t0, 16		# i = i / 16
	sw	$t0, 8($sp)		# i = i / 16
	
	lw	$t0, 4($sp)		# $t0 (j)
	addi	$t0, $t0, -1		# j = j - 1
	sw	$t0, 4($sp)		# j = j - 1
	
	j 	L4			# jump to L4
	
	E_L4:
	
	lw	$a0, 20($sp)		# Load arguments
	lw	$a1, 16($sp)		# Load arguments
	lw	$a2, 12($sp)		# Load arguments

	addi	$sp, $sp, 24		# Dealloc stack
	
	jr $ra
	
		
hexadecimalToBinario:			## HEXADECIMAL TO BINARIO PROCEDURE ##
					# $a0: endereco para .space 9 bytes (hexadecimal)
					# $a1: endereco para .space 33 bytes (binario)
					# $a2: endereco para .asciiz com caracteres hexadecimais
					# $a3: endereco para .asciiz com caracteres halfbyte binario
					# return void
					#
					# Based code
					# void hexaToBin(char *hexa, char *bin, char *charHexa, char *binOrder) {
					#     int i, j;
					#     for (i = 0; i < 9; i++) {
					#         for (j = 0; j < 16; j++) {
					#             if (hexa[i] == charHexa[j]) {
					#                 strncpy(&bin[i * 4], &binOrder[j * 4], 4);
					#             }
					#         }
					#     }
					# }
					# 
					# STACK
					# +-----------+
					# | $s1       | + 28
					# | $s0       | + 24
					# | $a0(&hex) | + 20
					# | $a1(&bin) | + 16
					# | $a2(&hOd) | + 12
					# | $a3(&bOd) | + 8
					# | i         | + 4
					# | j         | + 0
					# +-----------+ $sp
		
	addi	$sp, $sp, -32		# Alloc stack
	
	sw	$s1, 24($sp)		# Save $s1
	sw	$s0, 20($sp)		# Save $s0
	
	sw	$a0, 20($sp)		# Save arguments
	sw	$a1, 16($sp)		# Save arguments
	sw	$a2, 12($sp)		# Save arguments
	sw	$a3, 8($sp)		# Save arguments
	
	sw	$zero, 4($sp)		# i = 0
	L5: 	# for (int i = 0; i < 9; i++)
	lw	$t0, 4($sp)		# $t0 (i)
	bge 	$t0, 9, E_L5		# if i >= 9 then E_L5
	
	sw	$zero, 0($sp)		# j = 0
	L6: 	# for (int j = 0; j < 16; j++)
	lw	$t0, 0($sp)		# $t0 (j)
	bge	$t0, 16, E_L6		# if j >= 16 then E_L6
	
		# if (hex[i] == hOd[j])
	lw	$t0, 4($sp)		# $t0 (i)
	lw	$t1, 20($sp)		# $t1 (&hex)
	addu	$t1, $t1, $t0		# $t1 (&hex[i])
	lb	$s0, 0($t1)		# $s0 (hex[i])
	
	lw	$t0, 0($sp)		# $t0 (j)
	lw	$t1, 12($sp)		# $t1 (&hOr)
	addu	$t1, $t1, $t0		# $t1 (&hOr[j]
	lb	$s1, 0($t1)		# $s1 (hOr[j])
	
	bne	$s0, $s1, L7		# if hex[i] != hOr[j] then L7 (end loop j)
		
		# Copy value bOd to bin
	lw	$t0, 4($sp)		# $t0 (i)
	li	$t1, 4			# $t1 (4)
	mult	$t0, $t1		# $t0 (i * 4)
	mflo	$t0			# $t0 (i * 4)
	
	lw	$s0, 16($sp)		# $s0 (&bin)
	addu	$s0, $s0, $t0		# $s0 (&bin[i * 4])
	
	lw	$t0, 0($sp)		# $t0 (j)
	li	$t1, 4			# $t1 (4)
	mult	$t0, $t1		# $t0 (j * 4)
	mflo	$t0			# $t0 (j * 4)
	
	lw	$t1, 8($sp)		# $t1 (&bOr)
	addu	$t1, $t1, $t0		# $t1 (&bOr[j * 4]
	lw	$s1, 0($t1)		# $s1 (bOr[j * 4]
	
	sw	$s1, 0($s0)		# bin[i * 4] = binOrder[j * 4] (WORD)
	
	L7: 
	lw	$t0, 0($sp)		# j = j + 1
	addi	$t0, $t0, 1		# j = j + 1
	sw	$t0, 0($sp)		# j = j + 1
	
	j	L6
	
	E_L6:
	
	lw	$t0, 4($sp)		# i = i + 1
	addi	$t0, $t0, 1		# i = i + 1
	sw	$t0, 4($sp)		# i = i + 1
	
	j	L5
	
	E_L5:
	
	lw	$s1, 24($sp)		# Load $s1
	lw	$s0, 20($sp)		# Load $s0
	
	lw	$a0, 20($sp)		# Load arguments
	lw	$a1, 16($sp)		# Load arguments
	lw	$a2, 12($sp)		# Load arguments
	lw	$a3, 8($sp)		# Load arguments
	
	addi	$sp, $sp, 32		# Dealloc stack
	
	jr	$ra
	
	
	
	
	
	
	
	
	
	
	
	
	
					
					

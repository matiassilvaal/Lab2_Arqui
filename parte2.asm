.data
	msg: .asciiz "El resultado es: "
.text
# Subrutina MAIN
MAIN:
	# Las primeras dos lineas indican los valores en duro que se utilizaran, en este caso se carga 81 y 18
	li $s0, 81
	li $s1, 18
	# $a0 = $s0, $a1 = $s1, $a2 = $zero
	move $a0, $s0
	move $a1, $s1
	move $a2, $zero
	# Se llama a la subrutina EUCLIDES
	jal EUCLIDES
	# Se llama a la subrutina IMPRIMIR
	jal IMPRIMIR
	# Se llama a la subrutina END
	j END
# Subrutina EUCLIDES
EUCLIDES:
	# Se asigna el espacio al stack, luego se almacena la direccion actual de retorno en stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	# Se llama a la subrutina RECURSIVIDAD
	jal RECURSIVIDAD
# Subrutina RECURSIVIDAD
RECURSIVIDAD:
	# Se llama a la subrutina DIVISION
	jal DIVISION
	# Caso base, si $a3 es 0, entonces salta a VOLVER
	beqz $a3, VOLVER
	# Se llama a la subrutina RECURSIVIDAD
	jal RECURSIVIDAD
# Subrutina DIVISION
DIVISION:
	# $a2 = $a1 antes de la division
	move $a2, $a1
	# $v0 contiene el resultado de $a0/$a1, mientras que $a3 es el resto
	div $v0, $a0, $a1
	mfhi $a3
	# $a0 = $a1, ej: si era 81 y 18, ahora $a0 = 18
	move $a0, $a1
	# $a1 = $a3, ej: si era 81 y 18, ahora $a1 = 9, el resto
	move $a1, $a3
	# Se devuelve a RECURSIVIDAD, luego del jal
	jr $ra
# Subrutina VOLVER	
VOLVER:
	# Se carga la dirección de retorno guardada en stack
	lw $ra, 0($sp)
	# Se libera espacio de stack
	add $sp, $sp, 4
	# Se devuelve a MAIN
	jr $ra
# Subrutina IMPRIMIR
IMPRIMIR:
	# $v0 = 4, por lo tanto se carga un mensaje y se imprime
	li $v0, 4
	la $a0, msg
	syscall
	# $v0 = 1, por lo tanto se carga un entero y se imprime, en este caso es el resultado
	li $v0, 1
	la $a0, ($a2)
	syscall
	# Se devuelve a MAIN
	jr $ra
# Subrutina END
END:
	# $v0 = 10, por lo tanto finaliza el programa
	li $v0, 10
	syscall	
	
	

.data
	msg: .asciiz "El resultado es: "
.text
# Subrutina MAIN
MAIN:
	# Estos son los datos en duro, en este caso -1 y 4
	li $s0, -2
	li $s1, 4
	# Se salta a MULTIPLICACION
	j MULTIPLICACION
# Subrutina MULTIPLICACION
MULTIPLICACION:
	# Si $s0 o $s1 es 0, entonces salta a MULT0
	beqz $s1, MULT0
	beqz $s0, MULT0
	# Si $s1 es menor que 0, salta a MULT1
	bltz $s1, MULT1
	# Si $s0 es menor que 0, salta a MULT2
	bltz $s0, MULT2
	# Le resta 1 a $s1
	addi $s1, $s1, -1
	# $s2 = $s0 + $s2
	add $s2, $s0, $s2
	# Si $s1 no es igual a 0 se salta a MULTIPLICACION, en caso contrario salta a IMPRIMIR
	bnez $s1, MULTIPLICACION
	j IMPRIMIR
# Subrutina MULT0
MULT0:
	# Hace que el resultado final sea 0 y salta a IMPRIMIR
	li $s2, 0
	j IMPRIMIR
# Subrutina MULT1
MULT1:
	# Si $s0 es menor que 0, salta a MULT3
	bltz $s0, MULT3
	# Le resta 1 a $s0
	addi $s0, $s0, -1
	# $s2 = $s1 + $s2
	add $s2, $s1, $s2
	# Si $s0 no es igual a 0 salta a MULT1, sino, salta a IMPRIMIR
	bnez $s0, MULT1
	j IMPRIMIR
# Subrutina MULT2
MULT2:
	# Si $s1 es menor que 0, salta a MULT3
	bltz $s1, MULT3
	# Le resta 1 a $s1
	addi $s1, $s1, -1
	# s2 = $s0 + $s2
	add $s2, $s0, $s2
	# Si $s1 no es igual a 0 salta a MULT2, sino, salta a IMPRIMIR
	bnez $s1, MULT2
	j IMPRIMIR
# Subrutina MULT3
MULT3:
	# Niega $s0 y $s1, luego salta a MULTIPLICACION
	neg $s0, $s0
	neg $s1, $s1
	j MULTIPLICACION
# Subrutina IMPRIMIR
IMPRIMIR:
	# $v0 = 4 por lo que muestra el msg guardado
	li $v0, 4
	la $a0, msg
	syscall
	# $v0 = 1, por lo que muestra el valor guardado en $a0, en este caso $s2 (resultado final)
	li $v0, 1
	la $a0, ($s2)
	syscall
	# Salta a END
	j END
# Subrutina END
END:
	# $v0 = 10, por lo tanto finaliza el programa
	li $v0, 10
	syscall



		

.data
	Arreglo: .space 12
	flotante1: .float 0.1
	flotante2: .float 0.01
.text
# Subrutina MAIN
MAIN:
	# Datos en duro, carga en este caso 1 y -4
	li $s0, -120
	li $s1, -11
	# Crea una copia de los valores $s0 y $s1 en $s5 y $s6 respectivamente
	move $s5, $s0
	move $s6, $s1
	# Carga el valor de flotante1 en $f2 y el valor de flotante2 en $f4
	l.s $f2, flotante1
	l.s $f4, flotante2
	# Salta a DIVISION
	j DIVISION
# Subrutina DIVISION
DIVISION:
	# Si $s0 es menor que 0, salta a TRANSFORMAR1
	bltz $s0, TRANSFORMAR1
	# Si $s1 es menor que 0, salta a TRANSFORMAR2
	bltz $s1, TRANSFORMAR2
	# Si $s1 es mayor que $s0, salta a RESTO
	beqz $s0, END5
	bgt $s1, $s0, RESTO
	# $s0 = $s0 - $s1
	sub $s0, $s0, $s1
	# Se le suma 1 a $s2
	addi $s2, $s2, 1
	# Salta a DIVISION
	j DIVISION
# Subrutina TRANSFORMAR1
TRANSFORMAR1:
	# Niega el valor de $s0 y salta a DIVISION
	neg $s0, $s0
	j DIVISION
# Subrutina TRANSFORMAR2
TRANSFORMAR2:
	# Niega el valor de $s1 y salta a DIVISION
	neg $s1, $s1
	j DIVISION
# Subrutina RESTO
RESTO:
	# $s3 = $s0, es decir, el resto
	move $s3, $s0 
	# Se carga en $t0 el valor de 10
	li $t0, 10
	# $t1 = $s3
	move $t1, $s3
	# Salta a MULTIPLICACION
	j MULTIPLICACION
# Subrutina MULTIPLICACION
MULTIPLICACION:
	# Si $t1 es igual a 0, salta a RESTO2
	beqz $t1, RESTO2
	# Se resta 1 a $t0
	addi $t0, $t0, -1
	# $t2 = $t1 + $t2
	add $t2, $t1, $t2
	# Si $t0 no es 0, salta a MULTIPLICACION
	bnez $t0, MULTIPLICACION
# Subrutina RESTO2
RESTO2:
	# $s0 = $t2
	move $s0, $t2
	# Se carga un 0 en $t2
	li $t2, 0
	# Salta a DIVISION2
	j DIVISION2
# Subrutina DIVISION2
DIVISION2:
	# Si $s1 es mayor que $s0, salta a RESTO3
	bgt $s1, $s0, RESTO3
	# $s0 = $s0 - $s1
	sub $s0, $s0, $s1
	# Se suma 1 a $s4
	addi $s4, $s4, 1
	# Salta a DIVISION2
	j DIVISION2
# Subrutina RESTO3
RESTO3: 
	# $s3 = $s0, es decir, el resto
	move $s3, $s0
	# Se carga un 10 en $t0
	li $t0, 10
	# $t1 = $s3
	move $t1, $s3
	# Si $t3 es igual a 8, salta a MULTFLOAT
	beq $t3, 8, MULTFLOAT
	# Se guarda en Arreglo($t3) el valor de $s4
	sw $s4, Arreglo($t3)
	# Se suma 4 a $t3
	addi $t3, $t3, 4
	# Se carga un 0 en $s4
	li $s4, 0
	# Salta a MULTIPLICACION
	j MULTIPLICACION
# Subrutina MULTFLOAT
MULTFLOAT:
	# Se carga un 4 en $t3
	li $t3, 4
	# En $t4 se guarda el valor almacenado en Arreglo($zero)
	lw $t4, Arreglo($zero)
	# Se transforma $t4 a flotante y se guarta en $f6
	mtc1 $t4, $f6
	# En $t5 se guarda el valor almacenado en Arreglo($t3)
	lw $t5, Arreglo($t3)
	# Se transforma $t5 a flotante y se guarda en $f6
	mtc1 $t5, $f8
	# Salta a MULTFLOAT2
	j MULTFLOAT2
# Subrutina MULTFLOAT2
MULTFLOAT2:
	# Si $t4 es 0, salta a MULTFLOAT3
	beqz $t4, MULTFLOAT3	
	# Resta 1 a $t4
	addi $t4, $t4, -1
	# $f6 = $f6+$f2
	add.s $f6, $f6, $f2
	# Si $t3 es distinto de 0 salta a MULTFLOAT2
	bnez $t3, MULTFLOAT2
# Subrutina MULTFLOAT3
MULTFLOAT3:
	# Si $t5 es 0, salta a END1
	beqz $t5, END1	
	# Resta 1 a $t5
	addi $t5, $t5, -1
	# $f8 = $f8+$f4
	add.s $f8, $f8, $f4
	# Si $t5 es distinto de 0, salta a MULTFLOAT3
	bnez $t5, MULTFLOAT3
# Subrutina END1
END1:
	# Si $s5 es menor que 0, salta a END2
	bltz $s5, END2
	# Si $s6 es menor que 0, salta a END3
	bltz $s6, END3
	# Transforma $s2 a flotante y lo guarda en $f16
	mtc1 $s2, $f16
	cvt.s.w $f16, $f16
	# $f6 = $f6+$f8 y $f16 = $f16+$f6
	add.s $f6, $f6, $f8
	add.s $f16, $f16, $f6
	# $v0 = 2, por lo que se imprimira un flotante
	li $v0,2
	mov.s $f12, $f16
	syscall
	# $v0 = 10, finaliza el programa
	li $v0, 10
	syscall
# Subrutina END2
END2:
	# Si $s6 es menor que 0, salta a END4
	bltz $s6, END4
	# Transforma $s2 a flotante y lo guarda en $f16
	mtc1 $s2, $f16
	cvt.s.w $f16, $f16
	# $f6 = $f6+$f8 y $f16 = $f16+$f6
	add.s $f6, $f6, $f8
	add.s $f16, $f16, $f6
	# Niega $f16
	neg.s $f16, $f16
	# $v0 = 2, por lo que se imprimira un flotante
	li $v0,2
	mov.s $f12, $f16
	syscall
	# $v0 = 10, finaliza el programa
	li $v0, 10
	syscall
# Subrutina END3
END3:
	# Si $s5 es menor que 0, salta a END4
	bltz $s5, END4
	# Transforma $s2 a flotante y lo guarda en $f16
	mtc1 $s2, $f16
	cvt.s.w $f16, $f16
	# $f6 = $f6+$f8 y $f16 = $f16+$f6
	add.s $f6, $f6, $f8
	add.s $f16, $f16, $f6
	# Niega $f16
	neg.s $f16, $f16
	# $v0 = 2, por lo que se imprimira un flotante
	li $v0,2
	mov.s $f12, $f16
	syscall
	# $v0 = 10, finaliza el programa
	li $v0, 10
	syscall
# Subrutina END4
END4:
	# Transforma $s2 a flotante y lo guarda en $f16
	mtc1 $s2, $f16
	cvt.s.w $f16, $f16
	# $f6 = $f6+$f8 y $f16 = $f16+$f6
	add.s $f6, $f6, $f8
	add.s $f16, $f16, $f6
	# $v0 = 2, por lo que se imprimira un flotante
	li $v0,2
	mov.s $f12, $f16
	syscall
	# $v0 = 10, finaliza el programa
	li $v0, 10
	syscall
END5:
	# $v0 = 1, por lo que imprimira un entero
	li $v0,1
	move $a0, $s2
	syscall
	# $v0 = 10, finaliza el programa
	li $v0, 10
	syscall
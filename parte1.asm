# Texto que se mostrara por consola
.data
	msg: .asciiz "Por favor ingrese el primer entero: "
	msg2: .asciiz "Por favor ingrese el segundo entero: "
	msg3: .asciiz "El maximo es: "
.text
# Subrutina MAIN
MAIN:	
	# $v0 = 4, lo que indica que se imprimira un texto, el cual esta en $a0, syscall ejecuta segun $v0
	li $v0, 4 	
	la $a0, msg 	
	syscall 	
	# $v0 = 5, indica que se pedira un numero por pantalla, syscall ejecuta segun $v0	 
	li $v0, 5
	syscall
	# Se guarda el valor entregado en $t0, luego se repite el proceso para el segundo mensaje y se guarda el resultado en $t1
	la $t0, ($v0)
	li $v0, 4
	la $a0, msg2
	syscall
	li $v0, 5
	syscall
	la $t1, ($v0)
	# Si $t0 es mayor que $t1 salta a MAYOR1, sino va a MAYOR2
	bge $t0, $t1, MAYOR1
	j MAYOR2
# Subrutina
MAYOR1: 
	# Al igual que antes, se muestra un mensaje por pantalla
	li $v0, 4
	la $a0, msg3
	syscall
	# $v0 = 1 lo que indica que se mostrara un entero por pantalla, se carga el valor en $a0 (en este caso se carga $t0) y luego con syscall muestra por pantalla
	li $v0, 1
	la $a0, ($t0)
	syscall
	# Salta a END
	j END
# Subrutina
MAYOR2:
	# Al igual que antes, se muestra un mensaje por pantalla
	li $v0, 4
	la $a0, msg3
	syscall
	# $v0 = 1 lo que indica que se mostrara un entero por pantalla, se carga el valor en $a0 (en este caso se carga $t1) y luego con syscall muestra por pantalla
	li $v0, 1
	la $a0, ($t1)
	syscall
	# Salta a END
	j END
# Subrutina
END: 
	# $v0 = 10 indica fin del programa, luego se hace syscall para terminar
	li $v0,10
	syscall

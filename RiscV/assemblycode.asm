#leitura do inteiro 

.data
data_one: .word 0x00002000
.eqv PRINT_INT	1
.eqv READ_INT 5
.eqv EXIT 10


.text

	li a7, READ_INT	#solicitar primeiro numero
	ecall
	mv t0,a0
	li a7, READ_INT #solicitar segundo numero
	ecall 
	mv t1,a0
	
	mv t0,x5
	mv t1,x6

	
	add a0,x5,x6
	
	li a7,PRINT_INT
	ecall
	li a7,EXIT
	
	ecall
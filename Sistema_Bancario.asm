.data
sal: .asciiz "Informe o Saldo Inicial: "
menu: .asciiz "\n ------> MENU <------- \n1 -Mostrar o Saldo\n2 - Depósitar\n3 - Efetuar Saque \n0 - Sair\nOpção"
outsal: .asciiz "SALDO = "
outdep: .asciiz "Seu NOVO SALDO após o Depósito é: "
outdep2: .asciiz "Informe seu Depósito: "
outsaq: .asciiz "Seu NOVO SALDO apos o Saque é: "
outsaq2: .asciiz "Informe seu Saque: "
out: .asciiz "Sistema Finalizado!\n"
.text
.globl main  		# definindo a função principal a ser executada pela diretiva globl.
main:
li $v0, 4    		# preparando o processador pra receber uma string e imprimir.
la $a0, sal  		# lendo endereço de memória da variável sal.
syscall      		# executando instruções.
li $v0, 5   	        # lendo um número inteiro.
syscall     	        # executando instrução.
move $t0, $v0  		# copiando os dados do registrador $v0 para $t0, isso é necessário para que o valor em $v0 não se perca. 

rep:        
li $v0, 4    		# imprimindo uma string.
la $a0, menu  		# lendo endereço de memória da variável menu.
syscall       		# executando instruções.
li $v0, 5     		# lendo um número inteiro.
syscall       		# executando instrução.
move $t1, $v0  		# $t1 = $v0, isso é necessário sempre pra não se perder o valor.
beq $t1,0,sair 		# se $t1 == 0 entre na função sair.
jal opmenu      	# instrução jal, ela chama uma função, ela trabalha com a instrução  jr, jr $ra volta para alinha do jal que o chamou.
j rep      		# j (jump) é uma instrução que faz desvio incondicional, não precisa de condição para realizar a execução de um desvio.
 			
opmenu:
beq $t1,1,saldo		# se $t1 == 1, entre na função saldo.
beq $t1,2,deposito
beq $t1,3,saque

saldo:
li $v0, 4		# preparando o processador pra receber e imprimir uma string.
la $a0,outsal
syscall
li $v0, 1
move $a0, $t0
syscall
jr $ra

deposito:
li $v0, 4
la $a0,outdep2
syscall
li $v0, 5
syscall
move $t2, $v0
add $t0,$t0,$t2
li $v0, 4
la $a0, outdep
syscall
li $v0, 1
move $a0, $t0
syscall
jr $ra			# voltando pra função.

saque:
li $v0, 4
la $a0, outsaq2
syscall
li $v0, 5
syscall
li $v0, 4
la $a0, outsaq
syscall
li $v0, 1
move $a0, $t0
syscall
jr $ra

#Encerrando o programa.
sair:
li $v0, 4
la $a0, out
syscall
li $v0, 10
syscall
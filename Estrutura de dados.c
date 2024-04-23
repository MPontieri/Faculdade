/*
Você foi contratado para desenvolver um programa em C que simula operações bancárias básicas para clientes de um banco fictício.
O programa deve permitir que os clientes realizem saques, depósitos e transferências de dinheiro entre contas.

O programa deve ser estruturado da seguinte forma:

1. *Struct Cliente*: Deve ser definida uma estrutura Cliente contendo os seguintes campos:

  - nome: uma string de até 50 caracteres para armazenar o nome do cliente.

   - saldo: um número de ponto flutuante para armazenar o saldo da conta do cliente.

2. *Função criarCliente*: Deve ser implementada uma função criarCliente que recebe como argumentos o nome do cliente e o saldo inicial da conta,
e retorna um ponteiro para uma estrutura do tipo Cliente. Esta função deve alocar dinamicamente memória para o novo cliente, inicializar seus campos
com os valores fornecidos e retornar o ponteiro para o cliente criado.

3. *Funcionalidades do Banco*: As seguintes funcionalidades devem ser implementadas como funções:

   - sacar: recebe um ponteiro para um cliente e um valor a ser sacado da conta. Esta função deve verificar se o saldo é suficiente para o saque e,
   se for o caso, realizar a operação reduzindo o valor do saldo do cliente.

   - depositar: recebe um ponteiro para um cliente e um valor a ser depositado na conta. Esta função deve adicionar o valor ao saldo do cliente.

   - transferir: recebe dois ponteiros para clientes (remetente e destinatário) e um valor a ser transferido da conta do remetente para a conta do destinatário.
   Esta função deve verificar se o saldo do remetente é suficiente para a transferência e, se for o caso, realizar a operação reduzindo o valor do saldo do remetente
   e adicionando ao saldo do destinatário.

4. *Teste do Programa*: No programa principal (main), crie pelo menos dois clientes para teste , realize algumas operações como saques, depósitos
e transferências entre eles, e imprima os saldos resultantes.

5. *Liberação de Memória*: Não se esqueça de liberar a memória alocada para os clientes no final do programa.

Ao executar o programa, os clientes devem ser capazes de interagir com as funcionalidades bancárias, fornecendo seus nomes, realizando saques,
depósitos e transferências de dinheiro conforme necessário.

Você deve garantir que seu código seja robusto o suficiente para lidar com situações como saldo insuficiente para saque ou transferência, além de verificar
a correta alocação e liberação de memória para evitar vazamentos de memória.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>

// Estrutura cliente
typedef struct _cliente{
    char nome[51];
    float saldo;
} Cliente;

// Criar cliente
Cliente* criarCliente(char* nome, float saldoInicial) {
    Cliente* novoCliente = (Cliente*) malloc(sizeof(Cliente));
    if (novoCliente == NULL) {
        printf("Não foi possível alocar memória para um novo cliente.\n");
    }
    strcpy(novoCliente->nome, nome);
    novoCliente->saldo = saldoInicial;
    return novoCliente;
}

// Função saque
void sacar(Cliente* cliente, float valor) {
    if (cliente->saldo >= valor) {
        cliente->saldo -= valor;
        printf("Saque de R$%.2f realizado com sucesso. Saldo atual de %s: R$%.2f\n", valor, cliente->nome, cliente->saldo);
    } else {
        printf("Saldo insuficiente.\n");
    }
}

// Função depósito
void depositar(Cliente* cliente, float valor) {
    cliente->saldo += valor;
    printf("Depósito de R$%.2f realizado com sucesso. Saldo atual de %s: R$%.2f\n", valor, cliente->nome, cliente->saldo);
}

// Função tranferência
void transferir(Cliente* remetente, Cliente* destinatario, float valor) {
    if (remetente->saldo >= valor) {
        remetente->saldo -= valor;
        destinatario->saldo += valor;
        printf("Transferência de R$%.2f realizada com sucesso de %s para %s.\n", valor, remetente->nome, destinatario->nome);
    } else {
        printf("Saldo insuficiente.\n");
    }
}

// Saldo cliente
void imprimirSaldo(Cliente* cliente) {
    printf("Saldo de %s: R$%.2f\n", cliente->nome, cliente->saldo);
}

// Seleciona o cliente
Cliente* selecionarCliente(Cliente** clientes, int totalClientes) {
    int i, escolha;
    printf("Selecione um cliente:\n");
    for (i = 0; i < totalClientes; i++) {
        printf("%d. %s\n", i + 1, clientes[i]->nome);
    }
    scanf("%d", &escolha);
    if (escolha > 0 && escolha <= totalClientes) {
        return clientes[escolha - 1];
    } else {
        printf("Seleção inválida.\n");
    }
}

// Função main com interação
int main() {
    setlocale(LC_ALL, "portuguese");

    Cliente* clientes[3];
    clientes[0] = criarCliente("Mariana", 1000.0);
    clientes[1] = criarCliente("Matheus", 750.0);
    clientes[2] = criarCliente("Paulo", 400.0);

    int opcao, totalClientes = 3;
    float valor;
    Cliente *clienteSelecionado, *clienteDestino;

    printf("Bem-vindo ao GL BANK!\n\n");

    do {
        printf("\nMenu de Opções:\n");
        printf("1. Sacar dinheiro\n");
        printf("2. Depositar dinheiro\n");
        printf("3. Transferir dinheiro\n");
        printf("4. Mostrar saldo\n");
        printf("5. Sair\n");
        printf("Escolha uma opção: ");
        scanf("%d", &opcao);

        switch (opcao) {
            case 1:
                clienteSelecionado = selecionarCliente(clientes, totalClientes);
                if (clienteSelecionado) {
                    printf("\nValor do saque: ");
                    scanf("%f", &valor);
                    sacar(clienteSelecionado, valor);
                }
                break;
            case 2:
                clienteSelecionado = selecionarCliente(clientes, totalClientes);
                if (clienteSelecionado) {
                    printf("\nValor do depósito: ");
                    scanf("%f", &valor);
                    depositar(clienteSelecionado, valor);
                }
                break;
            case 3:
                printf("\nSelecione o remetente:\n");
                clienteSelecionado = selecionarCliente(clientes, totalClientes);
                if (clienteSelecionado) {
                    printf("\nSelecione o destinatário:\n");
                    clienteDestino = selecionarCliente(clientes, totalClientes);
                    if (clienteDestino && clienteDestino != clienteSelecionado) {
                        printf("\nValor da transferência: ");
                        scanf("%f", &valor);
                        transferir(clienteSelecionado, clienteDestino, valor);
                    } else {
                        printf("\nNão é possível transferir para o mesmo cliente.\n");
                    }
                }
                break;
            case 4:
                for (int i = 0; i < totalClientes; i++) {
                    imprimirSaldo(clientes[i]);
                }
                break;
            case 5:
                printf("\nObrigado por usar o GL BANK. Lesgo!\n");
                break;
            default:
                printf("\nOpção inválida. Tente novamente.\n");
        }
    } while (opcao != 5);

    for (int i = 0; i < totalClientes; i++) {
        free(clientes[i]);
    }

    return 0;
}

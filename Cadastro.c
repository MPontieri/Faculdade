#include <stdio.h>
#include <locale.h>
#include <string.h>

#define MAX 10

char senha[10], senha_correta[] = "patinha";
int opcao;

struct cadastro_cliente {
    char nome[30];
    char pet[30];
    char tel[15];
};

struct cadastro_pet {
    char pet_nome[30];
    int servico;
};

struct cadastro_cons {
    int data;
    int escolhe_dr;
    int escolhe_cliente;
};

int main(void) {
    setlocale(LC_ALL, "portuguese");
    printf("Digite a senha: ");
    scanf("%s", senha);

    while (strcmp(senha, senha_correta) != 0) {
        printf("ERRO DE SENHA\nDigite novamente: ");
        scanf("%s", senha);
    }

    int quant_cliente = 0;
    int quant_pet = 0;
    int quant_cons = 0;

    struct cadastro_cliente cliente[MAX];
    struct cadastro_pet pet[MAX];
    struct cadastro_cons consulta[MAX];

    while (1) {
        system("cls");
        printf("\n==== Super Petshop Matheus pontieri BCC ====\n\n");
        printf("1 - Cadastro cliente\n");
        printf("2 - Banho ou Tosa\n");
        printf("3 - Agendar consulta\n");
        printf("4 - Relatório Geral\n");
        printf("5 - SAIR\n");
        printf("\n===========================================\n");
        printf("Escolha uma opção: ");
        scanf("%d", &opcao);
        system("cls");

        switch (opcao) {
            case 1: {
                while (quant_cliente < MAX) {
                    printf("\nSuper Petshop Matheus pontieri BCC\n\n");

                    printf("Digite o nome do cliente: ");
                    scanf(" %[^\n]s", cliente[quant_cliente].nome);

                    printf("Digite o telefone do cliente: ");
                    scanf(" %[^\n]s", cliente[quant_cliente].tel);

                    printf("Digite o nome do pet: ");
                    scanf(" %[^\n]s", cliente[quant_cliente].pet);

                    quant_cliente++;

                    char escolha;
                    printf("Realizar cadastro de outro cliente? (S/N): ");
                    scanf(" %c", &escolha);
                    if (escolha != 'S' && escolha != 's') {
                        break;
                    }
                }
                break;
            }

            case 2: {
                while (quant_pet < MAX) {
                    printf("\nSuper Petshop Matheus pontieri BCC\n\n");

                    printf("Digite o nome do Pet: ");
                    scanf(" %[^\n]s", pet[quant_pet].pet_nome);

                    printf("Selecione uma das opções a seguir:\n");
                    printf("Digite 1 para Banho\n");
                    printf("Digite 2 para Tosa\n");
                    printf("Digite 3 para Banho e Tosa\n");
                    scanf("%d", &pet[quant_pet].servico);

                    quant_pet++;

                    char escolha;
                    printf("Agendar outro serviço? (S/N): ");
                    scanf(" %c", &escolha);
                    if (escolha != 'S' && escolha != 's') {
                        break;
                    }
                }
                break;
            }

            case 3: {
                while (quant_cons < MAX) {
                    printf("\nSuper Petshop Matheus pontieri BCC\n\n");

                    printf("Escolha o dia da consulta:\n");
                    printf("Digite 1 para Quarta-Feira\n");
                    printf("Digite 2 para Sábado\n");
                    scanf("%d", &consulta[quant_cons].data);

                    printf("Qual o cliente que terá o Pet consultado?\n");
                    for (int j = 0; j < quant_cliente; ++j) {
                        printf("%d - %s\n", j + 1, cliente[j].nome);
                    }
                    scanf("%d", &consulta[quant_cons].escolhe_cliente);

                    printf("Escolha o Doutor que irá realizar a consulta:\n");
                    printf("Digite 1 para consulta com o Doutora Matheus pontieri\n");
                    printf("Digite 2 para consulta com o Doutor Fabiano\n");
                    scanf("%d", &consulta[quant_cons].escolhe_dr);

                    quant_cons++;

                    char escolha;
                    printf("Agendar outra consulta? (S/N): ");
                    scanf(" %c", &escolha);
                    if (escolha != 'S' && escolha != 's') {
                        break;
                    }
                }
                break;
            }

            case 4: {
                printf("Clientes cadastrados:\n");
                for (int j = 0; j < quant_cliente; ++j) {
                    printf("\nCliente %d:\n", j + 1);
                    printf("Nome do Cliente: %s\n", cliente[j].nome);
                    printf("Telefone: %s\n", cliente[j].tel);
                    printf("Pet: %s\n", cliente[j].pet);
                }

                printf("\nPets cadastrados:\n");
                for (int k = 0; k < quant_pet; ++k) {
                    printf("\nPet %d: \n", k + 1);
                    printf("Nome do pet: %s\n", pet[k].pet_nome);

                    if (pet[k].servico == 1) {
                        printf("Serviço: Banho\n");
                    } else if (pet[k].servico == 2) {
                        printf("Serviço: Tosa\n");
                    } else if (pet[k].servico == 3) {
                        printf("Serviço: Banho e Tosa\n");
                    } else {
                        printf("Serviço: Valor cadastrado inválido\n");
                    }
                }

                printf("\nConsultas cadastradas:\n");
                for (int f = 0; f < quant_cons; ++f) {
                    printf("\nConsulta %d: \n", f + 1);
                    printf("Cliente: %s\n", cliente[consulta[f].escolhe_cliente - 1].nome);
                    if (consulta[f].escolhe_dr == 1) {
                        printf("Será consultado com o Doutor Matheus pontieri\n");
                    } else if (consulta[f].escolhe_dr == 2) {
                        printf("Será consultado com o Doutor Fabiano\n");
                    }
                }
                system("pause");
                break;
            }

            case 5:
                printf("Volte sempre ao Super Petshop Matheus pontieri BCC\n");
                return 0;

            default:
                printf("Opção inválida. Tente novamente.\n");
        }
    }

    return 0;
}
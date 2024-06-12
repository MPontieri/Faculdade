#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct _aluno {
    char nome[50];
    struct _aluno *proximo;
} Aluno;

typedef struct _pilha{
    Aluno *topo;
    int contador;
} Pilha;

Pilha* criarPilha(void){
    Pilha *p = malloc(sizeof(Pilha));
    if(p == NULL) {
        printf("Erro ao alocar memória para a pilha.\n");
        exit(1);
    }
    p->topo = NULL;
    p->contador = 0;
    return p;
}

void push (Pilha *p, char *nomeAluno){
    Aluno *novoAluno = malloc(sizeof(Aluno));
    if (novoAluno == NULL){
        printf("Erro ao alocar memória para o novo aluno.\n");
        exit(1);
    }
    strcpy(novoAluno->nome , nomeAluno);
    novoAluno->proximo = p->topo;
    p->topo = novoAluno;
    p->contador++;
}

int empty(Pilha *p){
    return p->contador == 0;
}

char* top(Pilha *p){
    if (empty(p)){
        printf("Pilha vazia.\n\n");
        return NULL;
    }
    return p->topo->nome;
}

int size(Pilha *p){
    return p->contador;
}

char* pop(Pilha *p){
    Aluno *nomeAluno;
    char *nomeRemovido;
    
    if(!empty(p)){
        nomeAluno = p->topo;
        nomeRemovido = strdup(nomeAluno->nome);
        if (nomeRemovido == NULL) {
            printf("Erro ao alocar memória para o nome removido.\n");
            exit(1);
        }
        p->topo = p->topo->proximo;
        p->contador--;
        free(nomeAluno);
        return nomeRemovido;
    } else {
        printf("Pilha vazia.\n\n");
        return NULL;
    }
}

int main(int argc, const char *argv[]){
    Pilha *p = criarPilha();
    push(p, "Mariana");
    push(p, "Matheus");
    push(p, "Paulo");
    
    char *removido = pop(p);
    if (removido != NULL) {
        printf("Aluno removido: %s\n", removido);
        free(removido);
    }

    char *topo = top(p);
    if (topo != NULL) {
        printf("Topo da pilha: %s\n", topo);
    }
    
    return 0;
}
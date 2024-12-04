#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

// Definição de tipos de tokens
typedef enum {
    TK_PROGRAM, TK_VAR, TK_INTEGER, TK_REAL, TK_BEGIN, TK_END,
    TK_IF, TK_THEN, TK_ELSE, TK_WHILE, TK_DO,
    TK_ASSIGN, // :=
    TK_SEMICOLON, TK_COLON, TK_COMMA, TK_DOT,
    TK_PLUS, TK_MINUS, TK_MULT, TK_DIV,
    TK_EQ, TK_NEQ, TK_LT, TK_LEQ, TK_GT, TK_GEQ,
    TK_IDENTIFIER, TK_NUMBER,
    TK_EOF
} TokenType;

typedef struct {
    TokenType type;
    char lexeme[100];
    int line;
} Token;

// Variáveis globais
Token currentToken;
int lineNumber = 1;

// Funções do analisador léxico
void nextToken(FILE *source);
void error(const char *message);

// Funções do analisador sintático
void CasaToken(TokenType expected);
void Programa();
void Bloco();
void ParteDeclaracoesVariaveis();
void DeclaracaoVariaveis();
void ListaIdentificadores();
void ComandoComposto();
void Comando();

void nextToken(FILE *source) {
    int c = fgetc(source);

    // Ignorar espaços, tabs e novas linhas
    while (isspace(c)) {
        if (c == '\n') lineNumber++;
        c = fgetc(source);
    }

    if (c == EOF) {
        currentToken.type = TK_EOF;
        strcpy(currentToken.lexeme, "EOF");
        return;
    }

    // Identificar identificadores e palavras reservadas
    if (isalpha(c)) {
        char buffer[100] = {0};
        int i = 0;

        while (isalnum(c) && i < sizeof(buffer) - 1) {
            buffer[i++] = c;
            c = fgetc(source);
        }
        ungetc(c, source);

        if (strcmp(buffer, "program") == 0) currentToken.type = TK_PROGRAM;
        else if (strcmp(buffer, "var") == 0) currentToken.type = TK_VAR;
        else if (strcmp(buffer, "integer") == 0) currentToken.type = TK_INTEGER;
        else if (strcmp(buffer, "real") == 0) currentToken.type = TK_REAL;
        else if (strcmp(buffer, "begin") == 0) currentToken.type = TK_BEGIN;
        else if (strcmp(buffer, "end") == 0) currentToken.type = TK_END;
        else if (strcmp(buffer, "if") == 0) currentToken.type = TK_IF;
        else if (strcmp(buffer, "then") == 0) currentToken.type = TK_THEN;
        else if (strcmp(buffer, "else") == 0) currentToken.type = TK_ELSE;
        else if (strcmp(buffer, "while") == 0) currentToken.type = TK_WHILE;
        else if (strcmp(buffer, "do") == 0) currentToken.type = TK_DO;
        else {
            currentToken.type = TK_IDENTIFIER;
        }
        strcpy(currentToken.lexeme, buffer);
        currentToken.line = lineNumber;
        return;
    }

    // Outros símbolos e operadores
    currentToken.lexeme[0] = c;
    currentToken.lexeme[1] = '\0';
    currentToken.line = lineNumber;

    switch (c) {
        case ':':
            c = fgetc(source);
            if (c == '=') {
                currentToken.type = TK_ASSIGN;
                strcpy(currentToken.lexeme, ":=");
            } else {
                currentToken.type = TK_COLON;
                ungetc(c, source);
            }
            break;
        case ';': currentToken.type = TK_SEMICOLON; break;
        case '.': currentToken.type = TK_DOT; break;
        case ',': currentToken.type = TK_COMMA; break;
        case '+': currentToken.type = TK_PLUS; break;
        case '-': currentToken.type = TK_MINUS; break;
        case '*': currentToken.type = TK_MULT; break;
        case '/': currentToken.type = TK_DIV; break;
        case '=': currentToken.type = TK_EQ; break;
        case '<':
            c = fgetc(source);
            if (c == '>') {
                currentToken.type = TK_NEQ;
                strcpy(currentToken.lexeme, "<>");
            } else if (c == '=') {
                currentToken.type = TK_LEQ;
                strcpy(currentToken.lexeme, "<=");
            } else {
                currentToken.type = TK_LT;
                ungetc(c, source);
            }
            break;
        case '>':
            c = fgetc(source);
            if (c == '=') {
                currentToken.type = TK_GEQ;
                strcpy(currentToken.lexeme, ">=");
            } else {
                currentToken.type = TK_GT;
                ungetc(c, source);
            }
            break;
        default:
            printf("%d: token não reconhecido [%c].\n", lineNumber, c);
            exit(1);
    }
}

void CasaToken(TokenType expected) {
    if (currentToken.type == expected) {
        nextToken(stdin);
    } else {
        printf("%d: token não esperado [%s].\n", currentToken.line, currentToken.lexeme);
        exit(1);
    }
}

void Programa() {
    CasaToken(TK_PROGRAM);
    CasaToken(TK_IDENTIFIER);
    CasaToken(TK_SEMICOLON);
    Bloco();
    CasaToken(TK_DOT);
}

void Bloco() {
    if (currentToken.type == TK_VAR) {
        ParteDeclaracoesVariaveis();
    }
    ComandoComposto();
}

void ParteDeclaracoesVariaveis() {
    CasaToken(TK_VAR);
    do {
        DeclaracaoVariaveis();
        CasaToken(TK_SEMICOLON);
    } while (currentToken.type == TK_IDENTIFIER);
}

void DeclaracaoVariaveis() {
    ListaIdentificadores();
    CasaToken(TK_COLON);
    if (currentToken.type == TK_INTEGER || currentToken.type == TK_REAL) {
        nextToken(stdin);
    } else {
        printf("%d: tipo inválido [%s].\n", currentToken.line, currentToken.lexeme);
        exit(1);
    }
}

void ListaIdentificadores() {
    CasaToken(TK_IDENTIFIER);
    while (currentToken.type == TK_COMMA) {
        CasaToken(TK_COMMA);
        CasaToken(TK_IDENTIFIER);
    }
}

void ComandoComposto() {
    CasaToken(TK_BEGIN);
    do {
        Comando();
        CasaToken(TK_SEMICOLON);
    } while (currentToken.type != TK_END);
    CasaToken(TK_END);
}

void Comando() {
    // Implementação de comandos, se necessário.
}

int main() {
    nextToken(stdin);
    Programa();
    if (currentToken.type != TK_EOF) {
        printf("%d: fim de arquivo não esperado.\n", currentToken.line);
        return 1;
    }
    printf("Compilação bem-sucedida.\n");
    return 0;
}

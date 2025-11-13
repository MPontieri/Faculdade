'''
Integrantes: Matheus Pontieri, Mariana Aparecida, Paulo Victor Haddad

O código resolverá apenas matrizes que estão dentro do escopo proposto (matrizes de ordem 2,3 e 4).

Para rodar o código nenhuma dependencia precisa ser instalada. 
O codigo começa perguntando qual será a ordem da matriz, apos isso começa a armazenas os dados de cada linha,
formando uma matriz com os coeficientes e uma matriz resultado, e então une as 2 em uma matriz aumentada.

Depois desse processo de coleta de dados, o código começa a executar o algoritmo de Gauss (escalonamento na matriz), e então
começa a substituir as equações para descobrir o valor da cada variavel e mostra-las no final do programa.
'''

print('=== Sistema de Equações Lineares ===')
print('O programa resolve sistemas de ordem 2, 3 ou 4 (mínimo 2, máximo 4).')

#Ordem da matriz
while True:
    try:
        ordem = int(input('\nInforme a ordem da matriz (2 a 4): '))
        if 2 <= ordem <= 4:
            break
        print('Valor inválido: digite 2, 3 ou 4.')
    except ValueError:
        print('Entrada inválida: digite um número inteiro.')

#Matriz de coeficientes e matriz resultado
coeficientes = []
resultados = []
i = 1
while i <= ordem:
    print(f'\n--- Equação {i} ---')
    linha = []
    for j in range(1, ordem + 1):
        while True:
            try:
                valor = int(input(f'Coeficiente x{j}: '))
                linha.append(valor)
                break
            except ValueError:
                print('Entrada inválida: digite um número inteiro.')
    while True:
        try:
            resultado = int(input('Resultado: '))
            resultados.append(resultado)
            break
        except ValueError:
            print('Entrada inválida: digite um número inteiro.')
    coeficientes.append(linha)
    i += 1

#Matriz aumentada
matriz = [list(map(float, coeficientes[i])) + [float(resultados[i])] for i in range(ordem)]

tol = 1e-12
sistema_singular = False

#Algoritmo de Gauss para resolver matriz
for i in range(ordem):
    pivot_row = max(range(i, ordem), key=lambda r: abs(matriz[r][i]))
    if abs(matriz[pivot_row][i]) < tol:
        sistema_singular = True
        break


    if pivot_row != i:
        matriz[i], matriz[pivot_row] = matriz[pivot_row], matriz[i]


    pivô = matriz[i][i]
    for j in range(i, ordem + 1):
        matriz[i][j] /= pivô


    for k in range(i + 1, ordem):
        fator = matriz[k][i]
        if abs(fator) > tol:
            for j in range(i, ordem + 1):
                matriz[k][j] -= fator * matriz[i][j]

#Substitui
if not sistema_singular:
    solucoes = [0.0] * ordem
    for i in range(ordem - 1, -1, -1):
        soma = 0.0
        for j in range(i + 1, ordem):
            soma += matriz[i][j] * solucoes[j]
        solucoes[i] = matriz[i][ordem] - soma

#Mostra resultados
    print('\n=== Solução do Sistema ===')
    for i in range(ordem):
        if abs(solucoes[i] - round(solucoes[i])) < 1e-9:
            print(f'X{i+1} = {int(round(solucoes[i]))}')
        else:
            print(f'X{i+1} = {solucoes[i]:.6f}')
else:
    print('\nO sistema não tem solução única (determinante = 0) ou é singular.')
    print('Pode haver infinitas soluções ou nenhuma, dependendo dos termos independentes.')
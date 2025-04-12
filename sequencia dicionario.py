def sequencia (n, memo={}):

    if n==0:
        return 0
    if n==1:
        return 1
    if n in memo:
        resultado = memo[n]
    
    resultado = sequencia(n-1)+2*sequencia(n-2)
    memo[n] = resultado
    print(memo)
    return resultado

n = int(input("Digite a posição da sequencia T: "))

print(f"o resultado é {sequencia(n)}")
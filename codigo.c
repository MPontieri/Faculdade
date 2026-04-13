#include <stdio.h>
#include <math.h>
#include <time.h>

#define N 30
#define EPS 1e-10

// log seguro
double log_base_safe(double base, double x) {
    if (base <= EPS) base = EPS;
    if (fabs(base - 1.0) < EPS) base = 1.0 + EPS;
    if (x <= EPS) x = EPS;

    return log(x) / log(base);
}

// evita que números tendam a 0
double normalize(double x) {
    if (isnan(x) || isinf(x)) return 0.0;

    if (fabs(x) < EPS) return EPS;
    if (fabs(x) > 1e10) return x / 1e10;

    return x;
}

int main() {

    clock_t inicio, fim;
    double tempo_gasto;

    double a1 = 3.0 / 2.0;
    double q = 2.0 / 3.0;

    double seq_original[N];
    double seq_nova[N];

    //INÍCIO MEDIÇÃO
    inicio = clock();

    //SEQUÊNCIA ORIGINAL
    seq_original[0] = a1;
    for (int i = 1; i < N; i++) {
        seq_original[i] = normalize(seq_original[i - 1] * q);
    }

    //NOVA SEQUÊNCIA
    seq_nova[0] = normalize(log_base_safe(3.0/2.0, 2.0/3.0));

    for (int i = 1; i < N; i++) {
        double base = normalize(seq_original[i - 1]);
        double qi = normalize(log_base_safe(base, 2.0/3.0));
        seq_nova[i] = normalize(seq_nova[i - 1] * qi);
    }

    //FIM DA MEDIÇÃO
    fim = clock();
    tempo_gasto = ((double)(fim - inicio)) / CLOCKS_PER_SEC;

    //PRINT SEQUÊNCIA
    printf("Sequencia original:\n");
    for (int i = 0; i < N; i++) {
        printf("a%d = %.10lf\n", i + 1, seq_original[i]);
    }

    //PRINT NOVA SEQUÊNCIA
    printf("\nNova sequencia:\n");
    for (int i = 0; i < N; i++) {
        printf("a%d' = %.10lf\n", i + 1, seq_nova[i]);
    }

    //TEMPO
    printf("\nTempo de calculo: %.10lf segundos\n", tempo_gasto);

    //SOMA
    printf("\nSoma acumulada da nova sequencia:\n");

    double soma = 0.0;

    for (int i = 0; i < N; i++) {
        soma += seq_nova[i];
        soma = normalize(soma);

        printf("S%d = %.10lf\n", i + 1, soma);
    }

    return 0;
}
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
    int total_pontos;
    int dentro = 0;
    double x, y;

    //printf("Informe o número total de pontos a gerar: ");
    scanf("%d", &total_pontos);

    // Início da contagem de tempo
    clock_t inicio = clock();

    // Semente do gerador de números aleatórios
    srand(time(NULL));

    for (int i = 0; i < total_pontos; i++) {
        x = (double)rand() / RAND_MAX;
        y = (double)rand() / RAND_MAX;

        if (x * x + y * y <= 1.0)
            dentro++;
    }

    // Estimativa de Pi
    double pi = 4.0 * dentro / total_pontos;

    // Fim da contagem de tempo
    clock_t fim = clock();
    double tempo = (double)(fim - inicio) / CLOCKS_PER_SEC;

    // Resultados
    printf("\n--- RESULTADO SEQUENCIAL ---\n");
    printf("Pontos gerados:         %d\n", total_pontos);
    printf("Pontos dentro do círculo: %d\n", dentro);
    printf("Estimativa de Pi:       %.10f\n", pi);
    printf("Tempo de execução:      %.4f segundos\n", tempo);

    return 0;
}

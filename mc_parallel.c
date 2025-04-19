#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

int main() {
    int total_pontos;
    int dentro = 0;
    double x, y;

    //printf("Informe o número total de pontos a gerar: ");
    scanf("%d", &total_pontos);

    // Início da contagem de tempo
    double inicio = omp_get_wtime();

    // Paralelização com OpenMP
    #pragma omp parallel
    {
        unsigned int seed = time(NULL) ^ omp_get_thread_num(); // semente única por thread
        int local_dentro = 0;

        #pragma omp for
        for (int i = 0; i < total_pontos; i++) {
            double x = (double)rand_r(&seed) / RAND_MAX;
            double y = (double)rand_r(&seed) / RAND_MAX;

            if (x * x + y * y <= 1.0)
                local_dentro++;
        }

        #pragma omp atomic
        dentro += local_dentro;
    }

    // Estimativa de Pi
    double pi = 4.0 * dentro / total_pontos;

    // Fim da contagem de tempo
    double fim = omp_get_wtime();
    double tempo = fim - inicio;

    // Resultados
    printf("\n=== RESULTADO MONTE CARLO PARALELO ===\n");
    printf("Pontos gerados:         %d\n", total_pontos);
    printf("Pontos dentro do círculo: %d\n", dentro);
    printf("Estimativa de Pi:       %.10f\n", pi);
    printf("Tempo de execução:      %.4f segundos\n", tempo);

    return 0;
}

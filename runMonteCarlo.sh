#!/bin/bash

SAIDA="resultados.txt"         # arquivo de saida (resultados)
THREADS_LIST=(1 2 4 8 16)      # número de threads disponíveis
PONTOS_FIXOS=10000000000       # 10 bilhoes (escalonamento forte)
TRABALHO_POR_THREAD=100000000  # 100 milhões (escalonamento fraco)

# Verifica se os arquivos fonte existem
if [ ! -f "mc_sequential.c" ]; then
    echo "Erro: arquivo sequencial não encontrado"
    exit 1
fi
if [ ! -f "mc_parallel.c" ]; then
    echo "Erro: arquivo paralelo não encontrado"
    exit 1
fi

# Compila os programas
echo "Compilando os programas"
gcc mc_sequential.c -o sequential
gcc -fopenmp mc_parallel.c -o parallel

# Limpa o arquivo de saída
echo "Benchmark Monte Carlo - $(date)" > "$SAIDA"

### Escalonamento Forte
echo "" >> "$SAIDA"
echo "===== ESCALONAMENTO FORTE =====" | tee -a "$SAIDA"
echo "Problema fixo: $PONTOS_FIXOS pontos" | tee -a "$SAIDA"

# Sequencial
echo "[S] Executando versão sequencial" | tee -a "$SAIDA"
echo "$PONTOS_FIXOS" | ./sequential >> "$SAIDA"

# Paralelo
for THREADS in "${THREADS_LIST[@]}"
do
    echo "" >> "$SAIDA"
    echo ">>> Threads: $THREADS" | tee -a "$SAIDA"
    echo "[P] Executando versão paralela com $THREADS threads" | tee -a "$SAIDA"
    OMP_NUM_THREADS=$THREADS ./parallel <<< "$PONTOS_FIXOS" >> "$SAIDA"
done


### Escalonamento Fraco
echo "" >> "$SAIDA"
echo "===== ESCALONAMENTO FRACO =====" | tee -a "$SAIDA"
echo "Trabalho proporcional: $TRABALHO_POR_THREAD pontos por thread" | tee -a "$SAIDA"

for THREADS in "${THREADS_LIST[@]}"
do
    TOTAL=$(( THREADS * TRABALHO_POR_THREAD ))

    echo "" >> "$SAIDA"
    echo ">>> Threads: $THREADS - Total de pontos: $TOTAL" | tee -a "$SAIDA"

	# Sequencial
    echo "[S] Executando versão sequencial" | tee -a "$SAIDA"
    echo "$TOTAL" | ./sequential >> "$SAIDA"

	# Paralelo
    echo "[P] Executando versão paralela com $THREADS threads" | tee -a "$SAIDA"
    OMP_NUM_THREADS=$THREADS ./parallel <<< "$TOTAL" >> "$SAIDA"
done

echo "" >> "$SAIDA"
echo "Benchmark finalizado! Resultados salvos em $SAIDA"
less $SAIDA

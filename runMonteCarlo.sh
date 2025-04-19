#!/bin/bash

SAIDA="resultados.txt"
INICIAL=100000                   # Começa com 10 mil pontos
MULTIPLICADOR=10                 # Multiplica por 10 a cada rodada
RODADAS=5                        # Quantas vezes vai multiplicar

# Verifica se os arquivos fonte existem
if [ ! -f "mc_sequential.c" ]; then
    echo "Erro: arquivo sequencial não encontrado"
    exit 1
fi
if [ ! -f "mc_parallel.c" ]; then
    echo "Erro: arquivo paralelo não encontrado"
    exit 1
fi

# compila os programas
echo "Compilando os programas"
gcc mc_sequential.c -o sequential
gcc -fopenmp mc_parallel.c -o parallel

# Limpa o arquivo de saída
echo "Benchmark Monte Carlo - $(date)" > "$SAIDA"

# executa os algoritmos
PONTOS=$INICIAL
for (( i=1; i<=$RODADAS; i++ ))
do
	echo "" >> "$SAIDA"
    echo "--------------------------------" >> "$SAIDA"
	echo "" >> "$SAIDA"

    echo "Rodada $i - $PONTOS pontos" | tee -a "$SAIDA"

	echo "[S] Executando versão sequencial"
    echo "$PONTOS" | ./sequential >> "$SAIDA"
	echo "" >> "$SAIDA"
	echo "[P] Executando versão paralela"
    echo "$PONTOS" | ./parallel >> "$SAIDA"
    
    # Atualiza o número de pontos
    PONTOS=$(( PONTOS * MULTIPLICADOR ))
done
echo "Benchmark finalizado! Resultados salvos em $SAIDA"
less $SAIDA

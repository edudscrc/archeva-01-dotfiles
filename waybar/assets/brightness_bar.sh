#!/bin/bash

# Obtém o brilho atual como float (por exemplo: 0.43)
BRIGHTNESS=$(busctl --user get-property rs.wl-gammarelay / rs.wl.gammarelay Brightness | awk '{print $2}')

# Converte para porcentagem
PERCENT=$(awk "BEGIN { printf \"%d\", $BRIGHTNESS * 100 }")

# Calcula quantas barras preencher (1 barra por cada 10%)
FILLED=$((PERCENT / 10))
EMPTY=$((10 - FILLED))

# Gera as barras
BAR=""
for ((i = 0; i < FILLED; i++)); do BAR+="▮"; done
for ((i = 0; i < EMPTY; i++)); do BAR+="▯"; done

# Exibe o ícone + barras
echo "󰃠 $BAR"

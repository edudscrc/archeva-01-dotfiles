#!/bin/bash

MAX_VOLUME=100

case "$1" in
  up)
    # Obtém o volume atual
    CURRENT_VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | awk -F. '{print $1}')

    # Só aumenta o volume se for menor que 100%
    if [ "$CURRENT_VOLUME" -lt "$MAX_VOLUME" ]; then
      wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    fi
    ;;
  down)
    # Diminui o volume em 5%
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    ;;
  mute)
    # Alterna entre mudo e não mudo
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;
  *)
    echo "Uso: $0 {up|down|mute}"
    exit 1
    ;;
esac

#!/bin/bash

# Získání seznamu dostupných audio výstupů (sinks)
sinks=$(pactl list short sinks | awk '{print $2}')

# Převeď seznam výstupů na pole
sinks_array=($sinks)

# Získání aktuálně aktivního výstupu
current_sink=$(pactl info | grep "Default Sink" | awk -F': ' '{print $2}')

# Hledání indexu aktuálně aktivního výstupu v poli
for i in "${!sinks_array[@]}"; do
    if [[ "${sinks_array[$i]}" == "$current_sink" ]]; then
        current_index=$i
        break
    fi
done

# Počet výstupů
num_sinks=${#sinks_array[@]}

# Přepnutí na následující výstup (cyklicky)
next_index=$(( (current_index + 1) % num_sinks ))
next_sink=${sinks_array[$next_index]}

# Nastavení nového aktivního výstupu
pactl set-default-sink $next_sink

# Výpis aktuálního výstupu
echo "Přepnuto na: $next_sink"

# Uložení nového indexu
current_index=$next_index

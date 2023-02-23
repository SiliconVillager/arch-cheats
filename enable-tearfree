#!/bin/bash

connectors=( $(xrandr | grep "\sconnected" | cut -d " " -f1) )

for c in ${connectors[@]}; do
    xrandr --output "$c" --set TearFree "$1"
done

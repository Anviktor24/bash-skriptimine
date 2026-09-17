#!/bin/bash
# Until-tsükkel: sama mis whileyl1, kuid kordab kuni tingimus saab tõeseks
loendur=1
until [ $loendur -gt 10 ]; do
    echo "Loendur: $loendur"
    ((loendur++))
done
echo "Valmis"

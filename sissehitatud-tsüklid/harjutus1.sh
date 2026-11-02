#!/bin/bash

echo "--- SISSEEHITATUD TSÜKLID JA PARAMEETRID ---"

# Tsükkel üle käsurea argumentide
if [ $# -eq 0 ]; then
    echo "Ühtegi argumenti ei antud. Kasutan vaikimisi loendit:"
    set -- "õun" "pirn" "banaan"
fi

echo "Töötlen elemente ($# tk):"
for element in "$@"; do
    echo " - Element: $element"
done

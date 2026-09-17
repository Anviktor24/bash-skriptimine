#!/bin/bash
# IFS ja sõnade jagamine
tekst="koer;kass;hiir"
IFS=';'
for sona in $tekst; do
    echo "Sõna: $sona"
done

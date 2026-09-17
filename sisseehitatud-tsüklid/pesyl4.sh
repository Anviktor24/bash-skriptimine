#!/bin/bash
# Failide töötlemine: for käib failid läbi, while loeb iga faili read
mkdir -p data
printf "esimene\nteine\n" > data/fail1.txt
printf "kolmas\nneljas\n" > data/fail2.txt
for fail in data/*.txt; do
    echo "Töötlen faili: $fail"
    while read -r rida; do
        echo "  Rida: $rida"
    done < "$fail"
done

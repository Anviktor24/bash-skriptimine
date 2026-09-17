#!/bin/bash
# Loendab 1 kuni 10, katkestab break abil, kui väärtus jõuab 7-ni
for i in {1..10}; do
    if [[ $i -eq 7 ]]; then
        echo "Jõudsin 7-ni, katkestan tsükli"
        break
    fi
    echo "i = $i"
done
echo "Pärast tsüklit"

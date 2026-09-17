#!/bin/bash
# While-tsükkel koos break-iga: katkestab, kui summa ületab 20
summa=0
i=1
while true; do
    summa=$((summa + i))
    echo "i = $i, summa = $summa"
    if [ $summa -gt 20 ]; then
        echo "Summa ületas 20, katkestan"
        break
    fi
    ((i++))
done

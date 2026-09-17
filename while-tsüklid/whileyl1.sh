#!/bin/bash
# While-tsükkel: loendab 1 kuni 10
loendur=1
while [ $loendur -le 10 ]; do
    echo "Loendur: $loendur"
    ((loendur++))
done
echo "Valmis"

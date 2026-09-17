#!/bin/bash
# Küsib numbreid, kuni kasutaja sisestab 0. Negatiivsed jäetakse continue abil vahele.
for (( ; ; )); do
    read -p "Sisesta number (0 = lõpp): " nr
    if ! [[ $nr =~ ^-?[0-9]+$ ]]; then
        echo "See pole täisarv, proovi uuesti"
        continue
    fi
    if [[ $nr -eq 0 ]]; then
        echo "Sisestasid 0, lõpetan"
        break
    fi
    if [[ $nr -lt 0 ]]; then
        echo "Negatiivne arv ($nr), jätan vahele"
        continue
    fi
    echo "Sisestasid: $nr"
done

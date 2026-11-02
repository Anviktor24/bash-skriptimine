#!/bin/bash

arv=1

while [ $arv -le 5 ]; do
    echo "Loendur on hetkel: $arv"
    ((arv++))
done

echo "While-tsükkel lõpetatud!"

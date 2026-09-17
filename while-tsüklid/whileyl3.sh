#!/bin/bash
# While-tsükkel loeb faili rida-realt
fail="nimed.txt"
printf "Mari\nJuku\nKati\n" > "$fail"
nr=1
while read -r rida; do
    echo "Rida $nr: $rida"
    ((nr++))
done < "$fail"

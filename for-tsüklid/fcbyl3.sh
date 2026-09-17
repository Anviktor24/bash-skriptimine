#!/bin/bash
# Pesastatud tsüklid: kui sisemine tsükkel jõuab 5-ni, katkestatakse mõlemad (break 2)
for i in {1..3}; do
    for j in {1..10}; do
        if [[ $j -eq 5 ]]; then
            echo "Sisemine tsükkel jõudis 5-ni, katkestan mõlemad tsüklid"
            break 2
        fi
        echo "i = $i, j = $j"
    done
done
echo "Pärast tsükleid"

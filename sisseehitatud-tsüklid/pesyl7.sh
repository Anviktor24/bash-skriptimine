#!/bin/bash
# Mustri otsimine: leiab sõnad, milles on täht p
declare -A arr=( [0,0]="apple,orange" [0,1]="banana,pear" [1,0]="grapefruit,pineapple" [1,1]="kiwi,mango" )
for (( i=0; i<=1; i++ )); do
    for (( j=0; j<=1; j++ )); do
        IFS=',' read -ra sonad <<< "${arr[$i,$j]}"
        for sona in "${sonad[@]}"; do
            if [[ $sona == *p* ]]; then
                echo "Leitud positsioonil [$i,$j]: $sona"
            fi
        done
    done
done

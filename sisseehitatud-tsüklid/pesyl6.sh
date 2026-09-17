#!/bin/bash
# Tingimuslaused pesastatud tsüklis: paaris või paaritu
declare -A arr=( [0,0]=1 [0,1]=2 [1,0]=3 [1,1]=4 )
for (( i=0; i<=1; i++ )); do
    for (( j=0; j<=1; j++ )); do
        if (( ${arr[$i,$j]} % 2 == 0 )); then
            echo "Paarisarv positsioonil [$i,$j]: ${arr[$i,$j]}"
        else
            echo "Paaritu arv positsioonil [$i,$j]: ${arr[$i,$j]}"
        fi
    done
done

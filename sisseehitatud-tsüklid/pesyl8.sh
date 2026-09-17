#!/bin/bash
# Edasijõudnud võtted: break 2, paralleelne töötlus ja funktsioon tsüklis
declare -A arr=( [0,0]=1 [0,1]=2 [1,0]=3 [1,1]=4 )

echo "--- break 2 ---"
for (( i=0; i<=1; i++ )); do
    for (( j=0; j<=1; j++ )); do
        if (( ${arr[$i,$j]} == 3 )); then
            echo "Break positsioonil [$i,$j]"
            break 2
        fi
        echo "Töötlen [$i,$j]: ${arr[$i,$j]}"
    done
done

echo "--- paralleelne töötlus ---"
for (( i=0; i<=1; i++ )); do
    for (( j=0; j<=1; j++ )); do
        (echo "Töötlen [$i,$j]: ${arr[$i,$j]}"; sleep 1) &
    done
done
wait

echo "--- funktsioon tsüklis ---"
tootle() {
    echo "Töötlen [$1,$2]: ${arr[$1,$2]}"
}
for (( i=0; i<=1; i++ )); do
    for (( j=0; j<=1; j++ )); do
        tootle $i $j
    done
done

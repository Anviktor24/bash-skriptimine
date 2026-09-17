#!/bin/bash
# 2D massiivi läbimine pesastatud tsüklitega
declare -A arr=( [0,0]=1 [0,1]=2 [1,0]=3 [1,1]=4 )
for (( i=0; i<=1; i++ )); do
    for (( j=0; j<=1; j++ )); do
        echo "Element [$i,$j]: ${arr[$i,$j]}"
    done
done

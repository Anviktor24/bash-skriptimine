#!/bin/bash
# While-tsükkel koos continue-ga: väljastab ainult paaritud arvud 1 kuni 10
i=0
while [ $i -lt 10 ]; do
    ((i++))
    if (( i % 2 == 0 )); then
        continue
    fi
    echo "Paaritu arv: $i"
done

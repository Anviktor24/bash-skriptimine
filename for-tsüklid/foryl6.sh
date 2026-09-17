#!/bin/bash
# Loome a.txt, b.txt, c.txt ja väljastame .txt failide nimed
touch a.txt b.txt c.txt
for fail in *.txt; do
    echo "Leidsin faili: $fail"
done

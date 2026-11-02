#!/bin/bash

valik=""

while [ "$valik" != "3" ]; do
    echo "--- MENÜÜ ---"
    echo "1) Kuva kuupäev"
    echo "2) Kuva praegune kasutaja"
    echo "3) Välju"
    read -p "Tee oma valik (1-3): " valik

    case $valik in
        1)
            echo "Tänane kuupäev: $(date)"
            ;;
        2)
            echo "Praegune kasutaja: $(whoami)"
            ;;
        3)
            echo "Head aega!"
            ;;
        *)
            echo "Tundmatu valik, proovi uuesti."
            ;;
    esac
    echo ""
done

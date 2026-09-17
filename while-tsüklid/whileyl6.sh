#!/bin/bash
# Select-menüü: kasutaja valib nime, Välju lõpetab
PS3="Vali nimi: "
select nimi in Mari Juku Kati Välju; do
    if [ "$nimi" == "Välju" ]; then
        echo "Head aega!"
        break
    elif [ -n "$nimi" ]; then
        echo "Tere, $nimi!"
    else
        echo "Vale valik, proovi uuesti"
    fi
done

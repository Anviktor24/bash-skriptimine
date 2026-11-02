#!/bin/bash
# php paigaldusskript

# kontrollime, mitu korda php7.0 korral ok installed on leitud
PHP=$(dpkg-query -W -f='${Status}' php7.0 2>/dev/null | grep -c 'ok installed')

# kui PHP muutuja väärtus võrdub 0-ga
if [ $PHP -eq 0 ]; then
    echo "Paigaldame php ja vajalikud lisad"
    apt install -y php7.0 libapache2-mod-php7.0 php7.0-mysql
    echo "php on paigaldatud"

# kui PHP muutuja väärtus võrdub 1-ga
elif [ $PHP -eq 1 ]; then
    echo "php on juba paigaldatud"
    which php
fi
# skripti lopp

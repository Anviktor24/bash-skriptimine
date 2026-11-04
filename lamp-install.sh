#!/bin/bash

# Määrame turvameetmed:
# set -e - peatab skripti töö koheselt, kui mõni käsk annab veakoodi
set -e

# DEBIAN_FRONTEND=noninteractive hoiab ära interaktiivsed küsimused pakettide paigaldamisel
export DEBIAN_FRONTEND=noninteractive

# ==========================================
# 0. ROOT-KASUTAJA KONTROLL
# ==========================================
# Kontrollime, kas skripti käivitatakse root-õigustes ($EUID peab olema 0)
if [ "$EUID" -ne 0 ]; then
  echo "Viga: Seda skripti peab käivitama root-kasutajana (kasuta sudo ./lamp-install.sh)." >&2
  exit 1
fi

echo "=========================================="
echo "  LAMP-keskkonna paigaldus alustab..."
echo "=========================================="

# ==========================================
# 1. PAKETILOEND JA ABIPAKETID
# ==========================================
echo "Uuendan paketiloendit ja kontrollin vajalikke abipakete..."
apt update

# Abipaketid, mis on vajalikud repositooriumite ja seadistuste jaoks
abipaketid=("wget" "ca-certificates" "gnupg" "debconf-utils")

for pkg in "${abipaketid[@]}"; do
  # Kontrollime dpkg-query abil, kas abipakett on juba paigaldatud
  if dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "install ok installed"; then
    echo "  -> Abipakett '$pkg' on juba olemas."
  else
    echo "  -> Paigaldan puuduva abipaketi: $pkg"
    apt install -y "$pkg"
  fi
done

# ==========================================
# 2. MYSQL SERVER 8.0 PAIGALDUS JA SEADISTUS
# ==========================================
MYSQL_PASS="SecureMySQLRootPass2026!"

# Kontrollime, kas mysql-server on juba süsteemis olemas
if dpkg-query -W -f='${Status}' mysql-server 2>/dev/null | grep -q "install ok installed"; then
  echo "MySQL 8.0 on juba paigaldatud, jätame paigalduse vahele."
else
  echo "MySQL 8.0 puudub. Alustan mitteinteraktiivset paigaldust..."
  
  # debconf-set-selections abil määrame eelnevalt vastused, et install ei küsiks midagi kasutajalt
  debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password $MYSQL_PASS"
  debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password $MYSQL_PASS"
  debconf-set-selections <<< "mysql-community-server mysql-community-server/default-auth-override select Use Strong Password Encryption (RECOMMENDED)"
  
  # Oracle MySQL APT konfiguratsioonipaketi seadistamine
  debconf-set-selections <<< "mysql-apt-config mysql-apt-config/select-server select mysql-8.0"
  debconf-set-selections <<< "mysql-apt-config mysql-apt-config/select-product select Ok"

  # Laadime alla Oracle MySQL ametliku APT konfiguraatori
  MYSQL_DEB="/tmp/mysql-apt-config_0.8.40-1_all.deb"
  if [ ! -f "$MYSQL_DEB" ]; then
    wget -O "$MYSQL_DEB" https://dev.mysql.com/get/mysql-apt-config_0.8.40-1_all.deb
  fi
  
  # Paigaldame konfiguraatori ja uuendame repositooriumid
  dpkg -i "$MYSQL_DEB"
  apt update
  apt install -y mysql-server
fi

# Tagame, et MySQL teenus töötab ja käivitub süsteemi käivitumisel
systemctl start mysql
systemctl enable mysql

# Loome /root/.my.cnf faili, et root saaks MySQL-i kasutada ilma parooli sisestamata
if [ ! -f /root/.my.cnf ]; then
  cat << EOF > /root/.my.cnf
[client]
host=localhost
user=root
password=$MYSQL_PASS
EOF
  chmod 600 /root/.my.cnf
  echo "Loodi /root/.my.cnf fail turvaliste õigustega (chmod 600)."
else
  echo "/root/.my.cnf on juba olemas, uuendan õigused."
  chmod 600 /root/.my.cnf
fi

# ==========================================
# 3. APACHE2 VEEBISERVERI PAIGALDUS
# ==========================================
# Kontrollime, kas apache2 pakett on olemas
if dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -q "install ok installed"; then
  echo "Apache2 on juba paigaldatud."
else
  echo "Paigaldan Apache2 veebiserveri..."
  apt install -y apache2
fi

# Käivitame ja lubame teenuse automaatse käivituse
systemctl start apache2
systemctl enable apache2

# Loome uue vaikimisi veebilehe (/var/www/html/index.html)
CURRENT_DATE=$(date "+%Y-%m-%d %H:%M:%S")
STUDENT_NAME="Viktor Vahtra"
STUDENT_GROUP="ITS25"

cat << EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="et">
<head>
    <meta charset="UTF-8">
    <title>LAMP Server</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; background-color: #f4f4f9; color: #333; }
        .container { background: white; padding: 30px; border-radius: 8px; display: inline-block; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h1 { color: #2ecc71; }
    </style>
</head>
<body>
    <div class="container">
        <h1>LAMP server töötab!</h1>
        <p><strong>Õpilane:</strong> $STUDENT_NAME</p>
        <p><strong>Grupp:</strong> $STUDENT_GROUP</p>
        <p>LAMP paigaldus õnnestus.</p>
        <p><strong>Paigaldatud:</strong> $CURRENT_DATE</p>
    </div>
</body>
</html>
EOF
echo "Vaikimisi veebileht /var/www/html/index.html on edukalt loodud."

# ==========================================
# 4. PHP 8.2 PAIGALDUS JA SEADISTUS
# ==========================================
# Kontrollime, kas php8.2 pakett on olemas
if dpkg-query -W -f='${Status}' php8.2 2>/dev/null | grep -q "install ok installed"; then
  echo "PHP 8.2 on juba paigaldatud."
else
  echo "Paigaldan PHP 8.2 ja vajalikud moodulid..."
  apt install -y php8.2 php8.2-cli php8.2-common php8.2-mysql libapache2-mod-php8.2
fi

# Taaskäivitame Apache2, et PHP moodul rakenduks
systemctl restart apache2

# Loome PHP testfaili (info.php)
cat << 'EOF' > /var/www/html/info.php
<?php
phpinfo();
?>
EOF
echo "PHP testfail /var/www/html/info.php on loodud."

# ==========================================
# 5. KOKKUVÕTE JA RAPORT
# ==========================================
# Kogume teenuste ja pakettide infot raporti jaoks
APACHE_VERSION=$(apache2 -v | head -n 1 | awk '{print $3}')
APACHE_STATUS=$(systemctl is-active apache2)
APACHE_ENABLED=$(systemctl is-enabled apache2)

PHP_VERSION=$(php -v | head -n 1 | awk '{print $2}')

# Parandatud rida: võtame mysql --version väljundist korrektse versiooninumbri
MYSQL_VERSION=$(mysql --version | awk '{print $3}')
MYSQL_STATUS=$(systemctl is-active mysql)
MYSQL_ENABLED=$(systemctl is-enabled mysql)

if [ -f /root/.my.cnf ]; then
  MY_CNF_STATUS="/root/.my.cnf - olemas"
else
  MY_CNF_STATUS="/root/.my.cnf - puudub"
fi

# Väljastame nõuetele vastava raporti
echo ""
echo "=========== LAMP REPORT ==========="
echo ""
echo "Apache2:"
echo "Version: $APACHE_VERSION"
echo "Status: $APACHE_STATUS"
echo "Autostart: $APACHE_ENABLED"
echo ""
echo "PHP:"
echo "Version: $PHP_VERSION"
echo ""
echo "MySQL:"
echo "Version: $MYSQL_VERSION"
echo "Status: $MYSQL_STATUS"
echo "Autostart: $MYSQL_ENABLED"
echo ""
echo "Apache default page:"
echo "/var/www/html/index.html"
echo ""
echo "PHP test page:"
echo "/var/www/html/info.php"
echo ""
echo "MySQL root configuration:"
echo "$MY_CNF_STATUS"
echo "==================================="

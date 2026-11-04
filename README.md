# LAMP-keskkonna automaatne paigaldusskript (`lamp-install.sh`)

Selles repositooriumis asub Bash-skript, mis on loodud LAMP-keskkonna (Linux, Apache2, MySQL 8.0, PHP 8.2) automaatseks, mitteinteraktiivseks paigaldamiseks ja seadistamiseks Debian-põhistesse süsteemidesse[cite: 1].

## 🚀 Funktsionaalsus ja omadused

Skript järgib rangelt nõuet kontrollida komponentide olemasolu enne igat paigaldust (korduvatel käivitustel ei paigaldata midagi uuesti, vaid teavitatakse kasutajat)[cite: 1, 11, 15]:

1. **Abipaketid:** Kontrollib ja paigaldab vajadusel paketid `wget`, `ca-certificates`, `gnupg` ja `debconf-utils`[cite: 2].
2. **Oracle MySQL Server 8.0:**
   - Kontrollib paigaldust `dpkg-query` abil[cite: 2].
   - Kasutab Oracle ametlikku APT repositooriumi (`mysql-apt-config`)[cite: 3].
   - Teostab mitteinteraktiivse paigalduse `debconf-set-selections` abil[cite: 3].
   - Loob automaatselt root-kasutajale faili `/root/.my.cnf` koos turvaliste õigustega (`chmod 600`)[cite: 4].
3. **Apache2 veebiserver:**
   - Kontrollib olemasolu ja käivitab teenuse (`active`, `enabled`)[cite: 5, 6].
   - Kirjutab üle vaikimisi veebilehe (`/var/www/html/index.html`), kuvades õpilase nime, grupi, staatuse ja paigalduse ajatempli[cite: 6, 7].
4. **PHP 8.2:**
   - Paigaldab PHP 8.2 koos vajalike moodulitega (`cli`, `common`, `mysql`, `libapache2-mod-php8.2`)[cite: 8].
   - Loob testfaili `/var/www/html/info.php`[cite: 8].
5. **Lõpuraport:** Kuvab töö lõpus korrastatud kokkuvõtte kõikide komponentide versioonidest, teenuste staatusest ja konfiguratsioonifailidest[cite: 9, 10].

---

## ⚙️ Kasutamine

1. **Klooni repositoorium serverisse:**
   ```bash
   git clone git@github.com:Anviktor24/bash-skriptimine.git
   cd bash-skriptimine

# Számrend ZH
## Elmélet

Mit csinál a következő kódrészlet?
```pwd=$(pwd)```  
Létrehozunk egy pwd nevű változót, és azt az értéket adjuk neki ami a pwd parancs outputja (1 pont)  
```for i in 0{1..9} {10..31}; do```  
Egy for ciklusban minden ismétlésben i-nek értéket adunk, kezdetben 01-09-ig, ezt követően 10-31-ig (2 pont)

```mkdir $pwd/11.$i.2017```

még mindig a ciklusban maradva létrehozunk egy mappát a pwd változóban meghatározott helyen, olyan módon hogy a neve egy dátum, 11.$i$.2017 formában, (tehát: 11.01.2017 ; 11.02.2017 … ) (2 pont)
*November csak 30 napos. (+0,1 pont)*

## Gyakorlat

### Írj scriptet, ami beolvas egy számot a bemenetről, majd kiírja a számjegyek összegét!

```sh
#!/bin/bash
#
# Bemenet ellenőrzése
if [ -z "$1" ]; then
  echo "Kérlek, adj meg egy számot argumentumként!"
  exit 1
fi

# Számjegyek összegének kiszámítása
osszeg=0
for (( i=0; i<${#1}; i++ )); do
  digit=${1:$i:1}
  osszeg=$((osszeg + digit))
done

# Eredmény kiírása
echo "$osszeg"
```

### Írj scriptet, ami kiírja a mellette találhato szamok.txt legnagyobb számát. A szamok.txt tetszőleges számú számot tartalmaz, amik szóközzel vagy enterrel vannak elválasztva. A file végén nincs feltétlenül üres sor.

```sh
#!/bin/bash

# Ellenőrizzük, hogy a szamok.txt létezik-e
if [ ! -f "szamok.txt" ]; then
  echo "Hiba: A szamok.txt fájl nem található!"
  exit 1
fi

# Legnagyobb szám meghatározása
max=$(tr -s ' \n' '\n' < szamok.txt | sort -n | tail -1)

# Eredmény kiírása
echo "A legnagyobb szám: $max"
```

### Készíts shell szkriptet, amelyik egy fájlban lévő vásárlások közül kilistázza a 10 000 HUF feletti termékek nevét. A fájl nevét paraméterként adjuk meg. 
A vásárlások formájaa: <ár> <üzlet> <termék neve> <dátum>
Pl.
1024 AQUA USB-kábel 2017.03.21
12480 ACME Dinamit 2018.12.25

```sh
#!/bin/bash

# Ellenőrizzük, hogy megadták-e a fájlnevet argumentumként
if [ -z "$1" ]; then
  echo "Használat: $0 <fájlneve>"
  exit 1
fi

# Ellenőrizzük, hogy a megadott fájl létezik-e
if [ ! -f "$1" ]; then
  echo "Hiba: A megadott fájl nem található!"
  exit 1
fi

# Feldolgozzuk a fájlt és kilistázzuk a 10 000 HUF feletti termékek nevét
awk '$1 > 10000 { print $3 }' "$1"
```
**Magyarázat**:  
1.	**Paraméter ellenőrzése**: A script ellenőrzi, hogy a fájl nevét megadták-e argumentumként. Ha nem, akkor figyelmeztetést ad, és kilép.
2.	**Fájl létezésének ellenőrzése**: Ha a fájl nem létezik, a script figyelmeztetést ad, és kilép.
3.	**Feldolgozás az** `awk` **parancssal**:
	•	Az awk segítségével vizsgáljuk meg, hogy az első oszlop (ár) nagyobb-e, mint 10 000.
	•	Ha a feltétel teljesül, akkor a harmadik oszlopot (termék nevét) írjuk ki.

**Használat**:  
1. Tedd futtathatóvá a scriptet:  
```chmod +x c.sh```  
2. Futtatás példa:  
```./c.sh vasarlasok.txt```

### Készíts shell szkriptet, ami bekér egy n számot, és Kirajzol # karakterekből álló derékszögű háromszöget, aminek a leghosszabb oldala n darab ‘#’-ből áll. Addig várja az n értéket, amíg egy 0 és 10 közötti számot kap.
```
$ ./d.sh 
3
#
##
###
$ ./d.sh 
0

$ ./d.sh 
5
#
##
###
####
#####
```  
```sh
#!/bin/bash

# Addig kérjük be az n értékét, amíg az 0 és 10 közötti nem lesz
while true; do
  read -p "Adj meg egy 0 és 10 közötti számot: " n

  # Ellenőrizzük, hogy a bemenet szám-e, és 0 és 10 között van-e
  if [[ "$n" =~ ^[0-9]+$ ]] && (( n >= 0 && n <= 10 )); then
    break
  else
    echo "Hiba: Adj meg egy 0 és 10 közötti számot!"
  fi
done

# Ha a megadott szám 0, akkor kilépünk a scriptből
if (( n == 0 )); then
  exit 0
fi

# Kirajzoljuk a háromszöget
for (( i = 1; i <= n; i++ )); do
  printf "%0.s#" $(seq 1 $i)
  echo
done
```
**Magyarázat:**  
1.  **Érték bekérése**: A while true ciklusban addig kérjük be az n értékét, amíg egy 0 és 10 közötti egész számot nem kapunk.
2.	**Bemenet ellenőrzése**: Az [[ "$n" =~ ^[0-9]+$ ]] kifejezés ellenőrzi, hogy a megadott érték szám-e. A (( n >= 0 && n <= 10 )) feltétel biztosítja, hogy az érték 0 és 10 közötti legyen.
3.	**Nulla ellenőrzése**: Ha n értéke 0, akkor a script kilép.
4.	**Háromszög rajzolása**: A for ciklusban az i változó 1-től n-ig megy, minden iterációban i darab # karaktert írunk ki egy új sorba.

**Használat:**  
1. Tedd futtathatóvá a scriptet:  
```chmod +x d.sh```

2. Futtatás:
```./d.sh```
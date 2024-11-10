#!/bin/bash
#
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
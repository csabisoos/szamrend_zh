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
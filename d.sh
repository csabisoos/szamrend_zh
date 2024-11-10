#!/bin/bash
#
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
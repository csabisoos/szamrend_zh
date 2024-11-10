#!/bin/bash
#
osszeg=0
for (( i=0; i<${#1}; i++ )); do
  digit=${1:$i:1}
  osszeg=$((osszeg + digit))
done

# Eredmény kiírása
echo "$osszeg"
#!/bin/bash
input="./01.input"
totalFuel=0

while IFS= read -r line
do
    fuel=$((($line / 3) - 2))
    totalFuel=$(($totalFuel + $fuel))
done < "$input"

echo "total fuel: $totalFuel"
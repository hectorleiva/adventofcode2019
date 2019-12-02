#!/bin/bash

input="./01.input"
totalFuel=0

function fuel_fuel_calculator() {
    intermediate_fuel=$1
    fuel_fuel_supply=0

    while true;
    do
        intermediate_fuel=$((($intermediate_fuel / 3) - 2))
        if [ $intermediate_fuel -le 0 ]
        then
            echo $fuel_fuel_supply
            return
        else
            fuel_fuel_supply=$(($fuel_fuel_supply + $intermediate_fuel))
        fi
    done
}

while IFS= read -r line
do
    fuel=$((($line / 3) - 2))
    fuel_fuel=$(fuel_fuel_calculator $fuel)
    totalFuel=$(($totalFuel + $fuel_fuel + $fuel))
done < "$input"

echo "total fuel: $totalFuel"
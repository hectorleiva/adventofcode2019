#!/usr/bin/env bash

input_file="./03.input"

declare -a arr
wire1=()
wire2=()

count=0
while read -r line; do
    arr[$count]=$(echo $line)
    (( count++ ))
done < "$input_file"

function direction_calculator() {
    declare -a distanceArr=()

    direction=${1:0:1}
    distance=${1:1}

    case $direction in
        'U')
            for ((i=1;i<=$distance;i++)); do
                distanceArr=("${distanceArr[@]}" $i)
            done
            wire2[$lastX]=${distanceArr[@]}
            echo ${wire2[$lastX]}

            lastY=$(( $lastY + $distance ))
            ;;
        'R')
            for ((i=1;i<=$distance;i++)); do
                echo $i
                wire2[$i]=$lastY
            done
            echo ${wire2[@]}

            lastX=$(( $lastX + $distance ))
            # echo 'we are going right'
            ;;
        'L')
            # echo 'we are going left'
            ;;
        'D')
            # echo 'we are going down'
            ;;
    esac
}

for n in "${arr[0]}"; do
    lastX=0
    lastY=0
    while IFS=',' read -ra coordinates; do
        for coord in ${coordinates[@]}; do
            direction_calculator $coord
        done
    done <<< "$n"
done


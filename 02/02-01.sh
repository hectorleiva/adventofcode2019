#!/bin/bash

input_file="./02.input"
INSTRUCTION_SET=()

IFS=',' 
while read line
do
    field=( $line )
    for num in "${field[@]}"; do
        INSTRUCTION_SET+=($num)
    done
done < "$input_file"

value=0
target=0
halt=false

function calculate_and_target() {
    arr=("$@")
    target=$(( arr[3] ))

    if (( arr[0] == 1 )); then
        value=$(( arr[1] + arr[2] ))
    elif (( arr[0] == 2 )); then
        value=$(( arr[1] * arr[2] ))
    else
       halt=true 
    fi

    return
}

for index in "${!INSTRUCTION_SET[@]}"; do
    indx=$(( $index + 1 ))

    if ! (( $indx % 4 )); then
        op=(${INSTRUCTION_SET[$index - 3]})
        val1=(${INSTRUCTION_SET[INSTRUCTION_SET[$index - 2]]})
        val2=(${INSTRUCTION_SET[INSTRUCTION_SET[$index - 1]]})
        pos=(${INSTRUCTION_SET[$index]})

        mini_set=($op $val1 $val2 $pos)
        calculate_and_target "${mini_set[@]}"

        if $halt; then
            echo "We are halting, value at position 0: ${INSTRUCTION_SET[0]}"
            exit
        fi

        INSTRUCTION_SET[$target]=${value}
    fi
done

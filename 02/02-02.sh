#!/bin/bash

input_file="./02.input"
INSTRUCTION_SET=()
TEMP_INSTRUCTION_SET=()

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

instruction_set_execute() {
    TEMP_INSTRUCTION_SET=("${INSTRUCTION_SET[@]}")
    TEMP_INSTRUCTION_SET[1]=${1}
    TEMP_INSTRUCTION_SET[2]=${2}

    for index in "${!TEMP_INSTRUCTION_SET[@]}"; do
        indx=$(( $index + 1 ))

        if ! (( $indx % 4 )); then
            op=(${TEMP_INSTRUCTION_SET[$index - 3]})
            val1=(${TEMP_INSTRUCTION_SET[TEMP_INSTRUCTION_SET[$index - 2]]})
            val2=(${TEMP_INSTRUCTION_SET[TEMP_INSTRUCTION_SET[$index - 1]]})
            pos=(${TEMP_INSTRUCTION_SET[$index]})

            mini_set=($op $val1 $val2 $pos)
            calculate_and_target "${mini_set[@]}"

            if $halt; then
                if (( ${TEMP_INSTRUCTION_SET[0]} == 19690720 )); then
                    echo "We are halting, value at position 0: ${TEMP_INSTRUCTION_SET[0]}"
                    echo "Noun: $1 and Verb: $2"
                    echo "Answer: $(( 100 * $1 + $2 ))"
                    exit
                fi
            fi

            TEMP_INSTRUCTION_SET[$target]=${value}
        fi
    done
}

for noun in {0..99}; do
    for verb in {0..99}; do
        instruction_set_execute $noun $verb
    done
done

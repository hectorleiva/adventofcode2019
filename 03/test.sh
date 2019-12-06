#!/bin/bash

test_arr1=( 1 2 3 )
test_arr2=( 1 2 3 )

if [ $test_arr1 = $test_arr2 ]; then
    echo "this works"
else
    echo "this does not work"
fi

test_arr3=(2 3)

test_arr1=("${test_arr3[@]}" "${test_arr1[@]}" )
echo ${test_arr1[@]}

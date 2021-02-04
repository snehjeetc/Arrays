#!/bin/bash -x 

declare -a array
declare -A tipletMap
size=0

inputNumbersToArray(){
    read -p "Enter the size of the array" size
    echo "Enter the integers"
    for((i=0; i<$size; i++))
    do
        read val
        array[$i]=$val
    done
}

mergeTwoSortedArrays(){
    temp_array=()
    index=0
    k=$1
    leftArray_start=$1
    leftArray_end=$(( $2 + 1))
    rightArray_start=$3
    rightArray_end=$(( $4 + 1))
    n=$5

    while [[ $leftArray_start -lt $leftArray_end 
            && $rightArray_start -lt $rightArray_end ]]
    do
        if [ ${array[$leftArray_start]} -ge ${array[$rightArray_start]} ]
        then
            temp_array[$index]=${array[$rightArray_start]}
            ((index++))
            ((rightArray_start++))
        else
            temp_array[$index]=${array[$leftArray_start]}
            ((index++))
            ((leftArray_start++))
        fi
    done

    while [ $leftArray_start -lt $leftArray_end ]
    do
        temp_array[$index]=${array[$leftArray_start]}
        ((index++))
        ((leftArray_start++))
    done

    while [ $rightArray_start -lt $rightArray_end ] 
    do
        temp_array[$index]=${array[$rightArray_start]}
        ((index++))
        ((rightArray_start++))
    done
    
    index=0
    while [ $k -lt $rightArray_end ]
    do
        array[$k]=${temp_array[$index]}
        ((k++))
        ((index++))
    done

    unset temp_array
}

merge_sort(){
    local start=$1
    local end=$2
    local n=$3      #size of the array to work on

    if [ $n -gt 1 ]
    then
        local mid=$(( ($start+$end)/2 ))
        merge_sort $start $mid $(( $mid-$start + 1 ))
        merge_sort $(($mid+1)) $end $(( $end-$mid ))
        mergeTwoSortedArrays $start $mid $(( $mid + 1 )) $end $n
    fi 
}

printArray(){
    for((k=0; k<$size; k++))
    do
        printf "%d " ${array[$k]}
    done
    printf "\n"
}

findTriplets(){
    key=1           #key to append in the triplet map
    for((i=0; i<$(($size-2)); i++))
    do
        firstVal=${array[$i]}
        j=$(($i+1))
        k=$(($size-1))
        sum=$((0-$firstVal))
        while [ $j -lt $k ]
        do
            if [ $((${array[$j]} + ${array[$k]})) -lt $sum ]
            then
                ((j++))
            elif [ $((${array[$j]} + ${array[$k]})) -gt $sum ]
            then
                ((k--))
            else
                t=$k
                while [[ $j -lt $t && $((${array[$j]}+${array[$t]})) -eq $sum ]]
                do
                    tripletMap[$key]=`echo $firstVal","${array[$j]}","${array[$t]}`
                    ((t--))
                    ((key++))
                done
                ((j++))
            fi
             
        done

    done
}

printTriplets(){
    echo "Total Number of triplets are: ${#tripletMap[@]}"
    for keys in ${!tripletMap[@]}
    do
        echo $keys " : " ${tripletMap[$keys]}
    done
}

inputNumbersToArray
merge_sort 0 $(($size-1)) $size
findTriplets
printTriplets

#!/bin/bash -x 

declare -a array
LENGTH_OF_ARRAY=10
maximum=99
second_maximum=99
minimum=1000
second_minimum=1000

generateRandomNumbers(){
    echo $(( RANDOM%900 + 100 ))
}

storeInArray(){
    index=$1
    value=$2
    array[$index]=$value
}

printArray(){
    for((k=0; k<${#array[@]}; k++))
    do
        printf "%d\t" ${array[$k]}
    done
    printf "\n"
}

AssignValuesIntoArray(){
    for((k=0; k<LENGTH_OF_ARRAY; k++))
    do
        val=$( generateRandomNumbers )
        storeInArray $k $val
    done
}

insertion_sort(){
    end=0  #end is for end index of sorted Array till now
    
    while [ $end -lt $((${#array[@]}-1)) ]
    do
        i=$(($end + 1))
        j=$end
        temp=${array[$i]}
        while [[ $i -ne 0 && $temp -lt ${array[$i-1]} ]]
        do
            array[$i]=${array[$j]}
            ((i--))
            ((j--))
        done
        array[$i]=$temp
        ((end++))
    done
}

getMin_Max(){

    local k=$((${#array[@]}-1))
    local j=0
    maximum=${array[$k]}
    minimum=${array[0]}
    ((k--))
    while [[ $k -ne 0 && $maximum -eq ${array[$k]} ]]
    do
        ((k--))
    done

    second_maximum=${array[$k]}
    
    ((j++))
    while [[ $j -ne $((${#array[@]}-1)) && $minimum -eq ${array[$j]} ]]
    do
        ((j++))
    done

    second_minimum=${array[$j]}

}

AssignValuesIntoArray
printArray
insertion_sort
printArray
getMin_Max
echo "Maximum : $maximum "
echo "Second Maximum : $second_maximum"
echo "Minimum : $minimum "
echo "Second Minimum : $second_minimum"

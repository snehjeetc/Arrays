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

getMin_Max(){
    for((k=0; k<${#array[@]}; k++))
    do
        if [ $maximum -lt ${array[$k]} ]
        then
            second_maximum=$maximum
            maximum=${array[$k]}
        elif [ $second_maximum -lt ${array[$k]} ]
        then
            second_maximum=${array[$k]}
        fi

        if [ $minimum -gt ${array[$k]} ]
        then
            second_minimum=$minimum
            minimum=${array[$k]}
        elif [ $second_minimum -gt ${array[$k]} ]
        then
            second_minimum=${array[$k]}
        fi

    done
}

AssignValuesIntoArray
printArray
getMin_Max
echo "Maximum : $maximum "
echo "Second Maximum : $second_maximum"
echo "Minimum : $minimum "
echo "Second Minimum : $second_minimum"

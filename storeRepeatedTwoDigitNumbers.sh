#!/bin/bash -x 

declare -a array
counter=0
lowerLimit=0
upperLimit=0

getRange(){
    read -p "Enter the [lower-limit -- upper-limit ]" lowerLimit upperLimit
    while [[ $lowerLimit -lt 0 && $upperLimit -gt 100 ]]
    do
        echo "Range beyond limits"
        read -p "Enter the [lower-limit -- upper-limit ]" lowerLimit upperLimit
    done
}

storeInTheArray(){
    array[$counter]=$1
    ((counter++))
}

storeRepeatingNumbersInArray(){
    for((k=$lowerLimit; k<=$upperLimit; k++))
    do
        if [[ $(($k%11)) == 0 && $k -ne 0 ]]
        then
            storeInTheArray $k
        fi
    done
}

printArray(){
    for((k=0; k<${#array[@]}; k++))
    do
        printf "%d " ${array[$k]}
    done
    printf "\n"
}

getRange
storeRepeatingNumbersInArray
printArray

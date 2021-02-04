#!/bin/bash -x 

declare -a primeFactorsOfN
index=0

addToArray(){
    value=$1
    primeFactorsOfN[$index]=$value
    ((index++))
}

storePrimeFactors(){
    num=$1
    while [ $(($num%2)) -eq 0 ]
    do 
        addToArray 2
        num=$(($num/2))
    done

    for (( i=3; i*i <= $num; i=i+2 ))
    do
        while [ $(($num%$i)) -eq 0 ]
        do
            addToArray $i
            num=$(($num/$i))
        done
    done

    if [ $num -gt 2 ]
    then
        addToArray $num
    fi
}

printPrimeFactors(){
    for((k=0; k<${#primeFactorsOfN[@]}; k++))
    do
        printf "%d " ${primeFactorsOfN[$k]}
    done
    printf "\n"
}

read -p "Enter the number: " num
storePrimeFactors $num
printPrimeFactors


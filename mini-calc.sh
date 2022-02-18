#!/bin/bash

# Mini script for basic calculation (addition, substraction, dividing, multiplexing)
# Pass two digits in following manner ./mini-calc [arg1] [arg2]

declare -i num1
declare -i num2

function argu() {
    if [ "$1" == 2 ]; then
        return 0
    else
        echo "Wrong number of arguments you should pass exactly two like: bash mini-calc.sh [arg1] [arg2] "
        exit 1
    fi 
}

function checkIfNum() {
    re='^[0-9]+$'
    if ! [[ $1 =~ $re ]] ; then
        echo "Error! You passed the number in wrong format. Please pass the numbers" 
        exit 1
    fi
}

function adding () {
    result=$(( "$1" + "$2" )) 
    echo ""$1" + "$2" = "$result""
}

function substracting () {
    result=$(( "$1" - "$2" )) 
    echo ""$1" - "$2" = "$result""
}

function multiplexing () {
    result=$(( "$1" * "$2" )) 
    echo ""$1" * "$2" = "$result""
}

function dividing () {
    echo ""
    echo "ATTENTION CALCULATOR WILL RETURN INTEGER VALUE ! "
    echo ""
    if [ "$2" == 0 ]; then
        echo "DIVIDING BY ZERO NOT ALLOWED. Exiting ..."
        exit 1
    else
        result=$(( "$1" / "$2" ))
        echo ""$1" / "$2" = "$result" "
        echo ""
    fi
}

function main() {

    echo ""
    echo "______________________________CALCULATOR_______________________________________"
    echo "YOU HAVE PASSED APPROPRIATE NUMBER OF ARGUMENTS ! TELL ME WHAT YOU WANT TO DO: "
    echo "--------------------------------------------------------------------------------"
    echo " "
select y in ADD SUBS DIV MUL Quit
do
  case $y in
    "ADD") echo "YOU CHOSE: ADDITION " 
    adding $1 $2 ;;
    "SUBS") echo "YOU CHOSE: SUBSTRACTION " 
    substracting $1 $2 ;;
    "DIV") echo "YOU CHOSE: DIVISION " 
    dividing $1 $2 ;;
    "MUL") echo "YOU CHOSE: MULTIPLEXING " 
    multiplexing $1 $2 
    ;;
    "Quit") exit ;;
    *) echo "YOU DIDN'T MAKE APPRPRIATE DECISION ! Exiting ...  "
    exit 1         
  esac
break
done
}

number="$#"
argu $number
checkIfNum $1
checkIfNum $2
main $1 $2 







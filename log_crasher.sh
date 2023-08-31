#!/bin/bash

# Bash script for facilitating the process of analyzing large amount of data gathered in log files 
# by sharing the most common operations used during log processing with awk, sed and grep options 

function pathGiver() {
    echo "PLEASE ENTER THE DIRECTORY NAME THAT CONTAINS THE ANALYZED DATA: "
    read CHOICE_DIR
    echo "You have entered following path: " $CHOICE_DIR
    echo ""
    echo "Please select the operation type: "
    echo ""
    select y in  WordCount Quit
        do
        case $y in "WordCount") 
        echo "-----------------------" 
        echo ""
        echo "Please select the word: "
        read word
        wordCounter $word $CHOICE_DIR;;
        "Quit") exit ;;
        *) echo "Exiting ... "
        exit 1
        esac
    break
    done
}

function wordCounter() {
    echo " " 
    echo "NUMBER OF OCCURENCES OF THE WORD:" \"$1\" "IN THE DIRECTORY:" \"$2\"
    echo " " 
    a=$2
    b=$1
    find ./${a} -name "*.log" | xargs grep -oh $b | wc -w  
}



function main() {

    echo ""
    echo "______________________________LOG CRASHER_______________________________________"
    echo "      WELCOME IN LOG_CRASHER - BASH TOOL FOR MAKING YOUR LOG DATA MORE CLEAR    "
    echo "--------------------------------------------------------------------------------"
    echo " "
    pathGiver
}

mainDir=""
main
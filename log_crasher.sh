#!/bin/bash

# Bash script for facilitating the process of analyzing large amount of data gathered in log files 
# by sharing the most common operations used during log processing with awk, sed and grep options
# Logs can be taken i.e. from https://github.com/logpai/loghub 

# Functionalities delievered so far:
# 1) WordCount                     
# 2) FileExtensionCount            
# 3) nMostCommonWordsCounter 
# 4) nMostCommonExtensionsCounter
# 5) nBiggestFilesCounter
# 6) nLatestFilesCounter

function pathGiver() {
    echo "PLEASE ENTER THE DIRECTORY NAME THAT CONTAINS THE ANALYZED DATA: "
    read CHOICE_DIR
    echo "You have entered following directory: " $CHOICE_DIR

    if test -d $CHOICE_DIR; then
        echo "Directory exists."
    else
        echo "Wrong directory name, exiting ... "
        echo ""
        exit
    fi

    echo ""
    echo "Please select the operation type: "
    echo ""
    select y in  WordCount FileExtensionCount nMostCommonWordsCounter nMostCommonExtensionsCounter nBiggestFilesCounter nLatestFilesCounter Quit
        do
        case $y in "WordCount") 
        echo "-----------------------" 
        echo ""
        echo "Please select the word: "
        read word
        wordCounter $word $CHOICE_DIR;;
        "FileExtensionCount") 
        echo "-----------------------" 
        echo ""
        echo "Please select the extension (without dot): "
        read extension
        fileExtensionCounter $extension $CHOICE_DIR;;
        "nMostCommonWordsCounter") 
        echo "-----------------------" 
        echo ""
        echo "Please select the number of most common words: "
        read numbers
        nMostCommonWordsCounter $numbers $CHOICE_DIR;;
        "nMostCommonExtensionsCounter") 
        echo "-----------------------" 
        echo ""
        echo "Please select the number of most common extensions: "
        read numbers
        nMostCommonExtensionsCounter $numbers $CHOICE_DIR;;
        "nBiggestFilesCounter") 
        echo "-----------------------" 
        echo ""
        echo "Please select the number of the biggest files: "
        read numbers
        nBiggestFilesCounter $numbers $CHOICE_DIR;;
        "Quit") exit ;;
        "nLatestFilesCounter") 
        echo "-----------------------" 
        echo ""
        echo "Please select the number of the recently modified files: "
        read numbers
        nLatestFilesCounter $numbers $CHOICE_DIR;;
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

function fileExtensionCounter() {
    echo " " 
    echo "NUMBER OF FILES WITH EXTENSION:" \"$1\" "IN THE DIRECTORY:" \"$2\"
    echo " " 
    a=$2
    b=$1
    find ./${a} -name "*.${b}" | wc -w  
}

function fileExtensionCounter() {
    echo " " 
    echo "NUMBER OF FILES WITH EXTENSION:" \"$1\" "IN THE DIRECTORY:" \"$2\"
    echo " " 
    a=$2
    b=$1
    find ./${a} -name "*.${b}" | wc -w  
}

function nMostCommonWordsCounter() {
    echo " " 
    echo "LISTING" $1 "MOST COMMON WORDS IN THE DIRECTORY:" \"$2\"
    echo " " 
    a=$2
    b=$1
    find ./${a} -name "*.log" | xargs sed -e 's/\s/\n/g' | sort | uniq -c | sort -nr | head -${b}
}

function nMostCommonExtensionsCounter() {
    echo " " 
    echo "LISTING" $1 "MOST COMMON FILE EXTENSIONS IN THE DIRECTORY:" \"$2\"
    echo " " 
    a=$2
    b=$1
    find ./${a} -type f | sed 's/.*\.//' | sort | uniq -c | sort -nr | head -n ${b}
}

function nBiggestFilesCounter() {
    echo " " 
    echo "LISTING" $1 "BIGGEST FILES IN THE DIRECTORY:" \"$2\"
    echo " " 
    a=$2
    b=$1
    find ./${a} -printf '%s %p\n'| sort -nr | head -n ${b}
}

function nLatestFilesCounter() {
    echo " " 
    echo "LISTING" $1 "RECENTLY MODIFIED FILES IN THE DIRECTORY:" \"$2\"
    echo " " 
    a=$2
    b=$1
    find ./${a} -type f | xargs ls -lt | head -n ${b} | awk '{print $6,$7,$8,$9}'
}

function main() {
    echo ""
    echo "______________________________LOG CRASHER_______________________________________"
    echo "      WELCOME IN LOG_CRASHER - BASH TOOL FOR MAKING YOUR LOG DATA MORE CLEAR    "
    echo "--------------------------------------------------------------------------------"
    echo " "
    pathGiver
}

main
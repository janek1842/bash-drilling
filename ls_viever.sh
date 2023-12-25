#!/bin/bash

# Bash script for facilitating the process of analyzing file metadata with ls command

# Functionalities delievered so far:
# 1) ModificationDate - listing files modified in recent N days/minutes
# 2) ModificationUser - listing files modified by particular user
# 3) FileExtension - listing files with particular extension

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
    select y in ModificationTime ModificationUser FileExtension
        do
        case $y in "ModificationTime") 
        echo "-----------------------" 
        echo " "
        echo "Please select the unit (days, minutes): "
        echo " "
        read unit
        echo " "
        echo "Please select the threshold (in $unit): "
        read bottomT
        echo ""

        listFilesOlderThanNDays $bottomT $CHOICE_DIR $unit ;;

        "ModificationUser") 
        echo "-----------------------" 
        echo ""
        echo "Please enter the name of the modifier: "
        read userek
        listFilesModifiedByParticularUser $userek $CHOICE_DIR;;

        "FileExtension") 
        echo "-----------------------" 
        echo ""
        echo "Please enter the extension: "
        read extension
        listFilesWithParticularExtension $extension $CHOICE_DIR;;

        "Quit") exit ;;
        *) echo "Exiting ... "
        exit 1
        esac
    break
    done
}

function listFilesOlderThanNDays() {

    if [ "$3" == "minutes" ]; then
        echo " " 
        echo "LISTING FILES THAT WERE MODFIED LESS THAN $1 MINUTES AGO IN THE DIRECTORY:" \"$2\"
        echo " " 
        a=$1
        b=$2 
        find ${b} -type f -mmin -$a  
    else
        echo " " 
        echo "LISTING FILES THAT WERE MODFIED LESS THAN $1 DAYS AGO IN THE DIRECTORY:" \"$2\"
        echo " " 
        a=$1
        b=$2 
        find ${b} -type f -mtime -$a  
    fi

}

function listFilesModifiedByParticularUser() {
    echo " " 
    echo "LISTING FILES THAT WERE MODFIED BY USER $1 IN THE DIRECTORY:" \"$2\"
    echo " " 
    a=$1
    b=$2 
    find ${b} -user $a
}

function listFilesWithParticularExtension() {
    echo " " 
    echo " LISTING FILES WITH EXTENSION $1 IN THE DIRECTORY:" \"$2\" 
    echo " " 
    a=$1
    b=$2 
    ls $b -all | egrep "\.$a"
}


function main() {
    echo ""
    echo "______________________________LS VIEWER_________________________________________"
    echo "      WELCOME IN LS VIEWER - BASH TOOL FOR MAKING YOUR FILES MORE MANAGEABLE    "
    echo "--------------------------------------------------------------------------------"
    echo " "
    pathGiver
}

main
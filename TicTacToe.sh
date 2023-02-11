#!/bin/bash

function displayCurrentTab(){
    echo ""
    echo " "" -----------------"
    echo " | " ${mainArray[0]} " | " ${mainArray[1]} " | " ${mainArray[2]} " | "
    echo " "" -----------------"
    echo " | " ${mainArray[3]} " | " ${mainArray[4]} " | " ${mainArray[5]} " | "
    echo " "" -----------------"
    echo " | " ${mainArray[6]} " | " ${mainArray[7]} " | " ${mainArray[8]} " | "
    echo " "" -----------------"
    echo ""
}

function checkIfWinnerPresent(){
    if { [ ${mainArray[0]} == ${mainArray[1]} ] && [ ${mainArray[1]} == ${mainArray[2]} ]; } || { [ ${mainArray[3]} == ${mainArray[4]} ] && [ ${mainArray[4]} == ${mainArray[5]} ]; } || { [ ${mainArray[6]} == ${mainArray[7]} ] && [ ${mainArray[7]} == ${mainArray[8]} ]; } ; then
        return 1
    elif { [ ${mainArray[0]} == ${mainArray[3]} ] && [ ${mainArray[3]} == ${mainArray[6]} ]; } || { [ ${mainArray[1]} == ${mainArray[4]} ] && [ ${mainArray[4]} == ${mainArray[7]} ]; } || { [ ${mainArray[2]} == ${mainArray[5]} ] && [ ${mainArray[5]} == ${mainArray[8]} ]; } ; then
        return 1
    elif { [ ${mainArray[0]} == ${mainArray[4]} ] && [ ${mainArray[4]} == ${mainArray[8]} ]; } || { [ ${mainArray[2]} == ${mainArray[4]} ] && [ ${mainArray[4]} == ${mainArray[6]} ]; } ; then
        return 1
    else
        return 2
    fi 
}

function printResultAndEndGame(){
        echo ""
        echo ""
        displayCurrentTab
        echo "Congratulations the winner is: " $1 "!!!"
        echo ""
        echo "" 
        exit 1
}

function checkIfCellAlreadyFilled(){

    if [ ${mainArray[$1-1]} == "X" ] || [ ${mainArray[$1-1]} == "O" ]; then
        echo ""
        echo "Sorry, this place is already taken. Please choose the free gap !"
        return 1
    else
        echo "You decided to choose gap no.  " $1
        return 2
    fi 
}

function fillTheGap(){
    mainArray[$1-1]=$2
}

function changePlayerAndStartRound(){

    MOVE_COUNTER=$(( "$MOVE_COUNTER" + "1" )) 
    
    if [ ${1} == "X" ]; then
        startRound "O"
    else
        startRound "X"
    fi 
    
}

function startRound(){
    CURRENT_PLAYER="$1"
    
    displayCurrentTab

    echo ""
    echo "NOW TIME TO MOVE FOR PLAYER " ${CURRENT_PLAYER}
    echo ""
    read CHOICE 

    checkIfCellAlreadyFilled $CHOICE 
    VAL_RESULT=$?

    if [ ${VAL_RESULT} -eq 2 ] ; then
        fillTheGap $CHOICE $CURRENT_PLAYER
        checkIfWinnerPresent
        WINNER=$?

        if [ ${WINNER} -eq 1 ]; then
        printResultAndEndGame $CURRENT_PLAYER
        fi 

        if [ ${MOVE_COUNTER} -eq 8 ]; then
        displayCurrentTab
        echo ""
        echo "THERE IS A DRAW !"
        exit 1
        fi 

        changePlayerAndStartRound $CURRENT_PLAYER
    else
        startRound $CURRENT_PLAYER
    fi 
}

function main() {
    echo ""
    echo "_____________X X X______________TIC TAC TOE__________O O O______________________"
    echo ""
    echo "CHOOSE THE GAME MODE AND CONFIRM WITH ENTER: "
    echo ""
    echo ""
    
    startRound "X"  
}

MOVE_COUNTER=0
mainArray=(1 2 3 4 5 6 7 8 9)
main


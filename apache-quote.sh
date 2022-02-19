#!/bin/bash

# Simple script which might help you to install and manage your apache web server or even create your first webpage
# Pss ! Here you can learn some funny polish quotes ! 

# This script is supposed to work only on Ubuntu :( 
# Some of the functions might be run only by sudoers 

function banner() {
	echo ""
	echo ""
	echo "-----------------------------------------------------------------"
	echo ""
	echo "                     WELCOME IN APACHE FRIEND                    "
	echo ""
	echo "-----------------------------------------------------------------"
	echo ""
	echo ""
}

red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 3`


function menu() {
	echo ""
	echo "-----------------------------------------------------------------"
	echo ""
	echo "                           MENU                                  "
	echo ""
	echo "-----------------------------------------------------------------"
	echo ""
	echo "Co wybierasz?"
	select y in ReposUpdate InstallApache StartApache StopApache StatusApache SelectQuote MakeYourWebPage Quit
	do
	case $y in
	"ReposUpdate") 	
	reposUpdate
	;;
	"InstallApache") installApache ;;
	"StartApache") restartApache ;;
	"SelectQuote") selectQuote ;;
	"StopApache") stopApache ;;
        "StatusApache") statusApache ;;
        "SelectQuote") selectQuote ;;
	"MakeYourWebPage") makeWebPage ;;
	"Quit") exit ;;	
	*) failMsg ;;
	esac
	break
	done		
}

function reposUpdate() {
	echo ""
	echo "${red}Your repositories will be updated, so you will be sure to have actual repos. "
	echo ""
	sudo apt-get update
}

function installApache() {
	echo ""
	echo "${green}Now, we will install Apache Server as long as it hasn't been yet installed  "
	echo ""
	reposUpdate
	sudo apt-get install apache2
	successMsg
}

function restartApache() {
	echo ""
	echo "${blue}Now, we will start Apache if it is running "
	echo ""
	sudo kill -9 $(sudo lsof -t -i:8000) 2> /dev/null	
	sudo service apache2 start -y 2>/dev/null 
}

function stopApache() {
	echo ""
	echo "Now, we will stop apache service"
	sudo service apache2 stop -y 
}

function statusApache() {
	echo ""
	echo "Now, we will check the status of th eapache service. "]
	echo ""
	sudo service apache2 status
}

function selectQuote() {
	echo ""
	echo "Now, we will replace our home page with some interesting quote :) "
	echo ""
	html=".html"
	myres=`shuf -i 1-9 -n 1`
	result="$myres${html}"
	cp html/"$result" ../../../var/www/html/index.html
	restartApache
	successMsg
}

function makeWebPage(){
	echo ""
	echo "Now, we will create our own webpage :) "
	echo "To do this, please create html file and copy it to html directory, then run this script again and select this option "
	echo ""
	result=`ls html -1 -t | head -1`
	echo "Current loaded file is ..."
	echo "$result"
	sudo cp html/"$result" ../../../var/www/html/index.html
	restartApache
}


function successMsg(){
echo ""
echo "Congrats ! You have succesfully updated your own webpage !"
echo ""
echo "If you want to visit it now, please type in your browser: 127.0.0.1:80 "
echo ""
}

function failMsg(){
echo ""
echo "Something went terribly wrong, please check your configuration, but now exiting ..."
echo ""
exit 1 
}

banner
menu
























!#/bin/bash

# Script for automated user adding and deletion and even more :)
# Please remember some of the features of this script can be run only with running this script with sudo permissions
# Work in progress ... 

function displayUsers() {
	awk -F: '{ print $1}' /etc/passwd
}	

function displayGroups() {
	getent group | cut -d: -f1
}

function displaySudoers() {
	grep '^sudo:.*$' /etc/group | cut -d: -f4
}

function addSomeGroup() {
	echo ""
	echo "Please type the name of the new group ( AVOID NAMES ALREADY EXISTING ! )"
	read group_name
	groupadd "$group_name"
	if [ "$?" == 0 ]; then
		echo " Congrats ! You have succesfully created a new group: "$group_name" :) "
	else
		echo "Something went wrong :( . Exiting ... "
		exit 1
	fi
}

function addUser() {
	echo ""
	echo "Please type the name of the new user ( AVOID NAMES ALREADY EXISTING ! )"
	read user_name
	useradd "$user_name"
	if [ "$?" == 0 ]; then
		echo " Congrats ! You have succesfully created a new user: "$user_name" :) "
	else
		echo "Something went wrong :(  Exiting ... "
		exit 1
	fi
}

function addUserToGroup() {
	echo ""
	echo "Please type the name of the user: "
	read username
	echo ""
	echo "Please type the name of the group: "
	read groupname
	usermod -a -G "$groupname" "$username"
	if [ "$?" == 0 ]; then
		echo " Congrats ! You have succesfully added "$username" to "$groupname"  :) "
	else
		echo "Something went wrong :(  Exiting ... "
		exit 1
	fi
}

function listUsersFromGroup() {
	echo ""
	echo "Please type the name of the group: "
	read groupname
	echo "HERE ARE USERS from: "$groupname""
	echo ""
	grep "$groupname" /etc/group | awk '{split($0,a,":"); print a[4] }'
	echo ""
	if [ "$?" == 0 ]; then
		echo " Congrats ! You might see users that belong to this group: "$groupname" "
	else
		echo "Something went wrong :(  Exiting ... "
		exit 1
	fi
}




function menuSelection() {
select y in  ListUsers ListGroups ListSudoers AddUser AddGroup AddUserToGroup ListUserFromGroup Quit
do
  case $y in "ListUsers") 
	echo "-----------------------"
	echo "Current list of users: " 
	echo "  "
	displayUsers
	;;
    "ListGroups")
	echo "-----------------------" 
	echo "Current list of groups: " 
	echo " "
	displayGroups
	;;
    "ListSudoers")  
	echo "-----------------------" 
	echo "Current list of sudo users: "
	echo " "
	displaySudoers
	;;
	"AddUser")  
	echo "-----------------------" 
	echo "Let's add some user ! "
	echo " "
	addUser
	;;
	"AddGroup") 
	echo "-----------------------" 
	echo "Let's add some group ! " 
	echo " "
	addSomeGroup;;
	"AddUserToGroup") 
	echo "-----------------------" 
	echo "Let's add some user to group ! " 
	echo " "
	addUserToGroup;;
	"ListUserFromGroup") 
	echo "-----------------------" 
	echo "Let's list users belonging to particular group ! " 
	echo " "
	listUsersFromGroup;;
    "Quit") exit ;;
    *) echo "SORRY IT'S WRONG DECISION. Eciting ... "
	exit 1
  esac
break
done
}

echo ""
echo "------------------------------------------------------------"
echo ""
echo "               WELCOME IN MY USER MANAGER :)             "
echo ""
echo "------------------------------------------------------------"
echo ""
echo "MENU: "


menuSelection





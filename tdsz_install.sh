#!/bin/bash
clear

#  The Dead Squad Zombie HoneyPot Installer
#  Christian Marvel
#  By Digitalized Warfare for HTTP://WWW.THEDEADSQUAD.COM
#  This Cannot Be REMOVED. 

## ----------------------------------
# Define variables
# ----------------------------------
EDITOR=nano
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'

# ----------------------------------------------
# Pauses and Alerts
# ----------------------------------------------
pause(){
  read -p " Press [Enter] key to continue..." fackEnterKey
  clear
}

# ----------------------------------------------
# Install Dependancys
# ----------------------------------------------
install_deps(){
	clear
	echo "We need to Update your System : "
	apt-get update&&apt-get upgrade -y&&apt-get dist-upgrade -y&&apt-get install expect tcl8.5 -y&&updatedb
	read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
	clear
	updatedb
	echo "We need to change the Default SSH Port.. Yes.. You will have to log"
	echo "again to the correct port....15022 "
	read -p "Press [Enter] key to continue.." fackEnterKey
	clear
	mkdir -p /opt/tdsz_backup/etc/confs/ssh/
	cp /etc/ssh/sshd_config /opt/tdsz_backup/etc/confs/ssh/
	mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
	cp /opt/tds_zombie/etc/confs/ssh/sshd_config /etc/ssh/sshd_config
	read -p "Press [Enter] key to restart SSH services.." fackEnterKey
	/etc/init.d/./ssh restart
	echo " "
	echo "We need to in Install the Panel System : "
	read -p "Press [Enter] key to continue..." fackEnterKey
	ln -s /opt/tds_zombie/bin/tdsz_portal.sh /bin/tdsz_portal
	chmod +x /bin/tdsz_portal
	chmod +x /opt/tds_zombie/bin/tdsz_portal.sh
	updatedb
	clear
}


# ----------------------------------------------
# These are the Text Menus
# ----------------------------------------------
# Main Menu
main_menu() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " The Dead Squad Zombie HoneyPot System V.1 Alpha "
	echo ' By Digitalized Warfare for HTTP://WWW.THEDEADSQUAD.COM'
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " This software will install multiple honeypots on your system. Each"
	echo " HoneyPot is designed to capture certain attacks. I have build a few"
	echo " various honeypots for you to get started on your way... Good Luck..."
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo ' 1. System Installation '
	echo " "
	echo " 0. To Exit The Dead Squad Zombie Installer"
}



# ----------------------------------------------
# These are the Menu Options
# ----------------------------------------------
# Main Menu Options
main_menu_options(){
	local menu_choice
	echo " "
	read -p " Main Menu Enter choice [ 1 or 0 ] " menu_choice
	case $menu_choice in
		1) install_deps ;;
		0) exit 0;;
		*) echo -e " ${RED}Error...${STD}" && sleep 2
	esac
}


# ----------------------------------------------
# Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP

# -----------------------------------
# Main logic - infinite loop
# ------------------------------------
while true
do
	main_menu
	main_menu_options
done

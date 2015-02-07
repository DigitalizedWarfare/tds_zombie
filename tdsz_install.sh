#!/bin/bash
clear
#!/bin/bash
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
	apt-get update
	read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
	clear
	echo "We need to Install Some System Support Files : "
	apt-get install git -y
	read -p "System Support Files Installed : Press [Enter] key to continue..." fackEnterKey
	clear
}
install_panel(){
	clear
	echo "We need to in Install the Panel System : "
	read -p "Press [Enter] key to continue..." fackEnterKey
	clear
	echo "Removing Old Version"
	rm -rf /opt/tds_zombie
	pause
	echo "We need to Install Source from GIT Hub : "
	cd /opt&&git clone https://github.com/DigitalizedWarfare/tds_zombie.git
	read -p "GIT Cloned : Press [Enter] key to continue..." fackEnterKey
	ln -s /opt/bin/tdz_portal.sh /usr/local/bin/tdz_portal
	chmod +x /usr/local/bin/tdz_portal
	chmod +x /opt/bin/tdz_portal.sh
	clear
}

change_ssh_port(){
		clear
		echo "We need to change the Default SSH Port.. Yes.. You will have to log"
		echo "again to the correct port.... "
		read -p "Press [Enter] key to continue port change and restart ssh services.." fackEnterKey
		clear
		mkdir -p /opt/tdsz_backup/etc/confs/ssh/
		mv /etc/ssh/sshd_config /opt/tdsz_backup/etc/confs/ssh/
		cp -v /opt/tds_zombie/etc/confs/ssh/sshd_conf /etc/ssh/sshd_config
		/etc/init.d/./ssh restart
		exit
}

# ----------------------------------------------
# These are the Menu Loaders
# ----------------------------------------------
# System Install
system_install(){
	while true
	do
		install_menu
		install_menu_options
	done
}
system_config(){
	while true
	do
		config_menu
		config_menu_options
	done
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
	echo ' 1. System Installation : Install and Update First '
	echo ' 2. Panel Installation : Install Panel from Git Source '
	echo " "
	echo " 0. To Exit The Dead Squad Zombie Installer"
}

# Install Menu
install_menu() {
	clear
	echo " The Dead Squad Zombie HoneyPot System V.1 Alpha "
	echo ' By Digitalized Warfare HTTP://WWW.THEDEADSQUAD.COM'
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " We need to make sure you have all the required files needed to run the"
	echo " Honeypots. This section will first get the most up to date files and"
	echo " then Configure them for you. Feel free to edit them after..."
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " 1. Install Required System Files"
	echo " 2. Install System Panel Sources"
	echo " 3. Change SSH Ports"
	echo " "
	echo " 0. To Exit to the Main Menu "
}


# ----------------------------------------------
# These are the Menu Options
# ----------------------------------------------
# Main Menu Options
main_menu_options(){
	local menu_choice
	echo " "
	read -p " Main Menu Enter choice [ 1 - 3 or 0 ] " menu_choice
	case $menu_choice in
		1) system_install ;;
		0) exit 0;;
		*) echo -e " ${RED}Error...${STD}" && sleep 2
	esac
}

# Install Menu Options
install_menu_options(){
	local install_choice
	echo " "
	read -p " Install Menu Enter choice [ 1 - 3 or 0 ] " install_choice
	case $install_choice in
		1) install_deps ;;
		2) install_panel ;;
		3) change_ssh_port ;;
		0) break;;
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

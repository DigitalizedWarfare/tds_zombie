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
# HoneyPot Software Installers
# ----------------------------------------------
install_kippo(){
	clear
	echo "We need to Update your System : "
	apt-get update&&apt-get upgrade -y&&apt-get dist-upgrade -y&&update
	echo "We need to Install System Files for Kippo : "
	apt-get install python-dev openssl python-openssl python-pyasn1 python-twisted authbind build-essential libmysqlclient-dev python-pip python-mysqldb mysql-server libcap2-bin -y
	echo " "
	echo "Checking for Kippo Account. Create if needed"
	adduser --disabled-login kippo
	echo " "
	echo "Cloning Kippo Git Source : Please Wait:"
	cd /opt
	git clone https://github.com/desaster/kippo.git
	echo " "
	echo "Setting Up Authbind"
	touch /etc/authbind/byport/22
	chown kippo /etc/authbind/byport/22
	chmod 777 /etc/authbind/byport/22
	echo " "
	echo "Adding Kippo Config Files"
	mkdir -p /opt/tds_zombie/logs/kippo/
	cp /opt/tds_zombie/etc/confs/kippo/kippo.cfg /opt/kippo/kippo.cfg
	echo " "
	echo "Adding File System to Kippo HoneyPot"
	cd /opt/kippo/utils
	./createfs.py > fs.pickle
	echo " "
	echo "Adding Files to File System"
	cd ../honeyfs
	cat /etc/passwd > etc/passwd
	cat /etc/hostname > etc/hostname
	cat /etc/hosts > etc/hosts
	cat /proc/cpuinfo > proc/cpuinfo
	cat /proc/meminfo > proc/meminfo
	cat /proc/version > proc/version
	cat /etc/shadow > etc/shadow
	echo " "
	echo "Adding Extra Commands to Honeypot"
	cd ../txtcmds
	df > bin/df
	dmesg > bin/dmesg
	mount > bin/mount
	ulimit > bin/ulimit
	perl -v > bin/perl
	ifconfig > sbin/ifconfig
	setcap 'cap_net_bind_service=+ep' /usr/bin/python2.7
	apt-get install phpmyadmin -y
	mkdir -p /opt/tdsz_backup/etc/confs/apache2/sites-available/
	mkdir -p /opt/tdsz_backup/etc/confs/apache2/sites-available/sites-enabled
	
	# Copy Files to Backup Folder
	echo "Copying Files to Backup Folder"
	cp /etc/apache2/ports.conf /opt/tdsz_backup/etc/confs/apache2/ports.conf
	cp /etc/apache2/sites-available/* /opt/tdsz_backup/etc/confs/apache2/sites-available/
	
	# Backup and Move Old Files
	echo "Moving Existing Apache Files"
	mv /etc/apache2/ports.conf /etc/apache2/ports.conf.bak
	mv /etc/apache2/sites-available/default /etc/apache2/sites-available/default.bak
	mv /etc/apache2/sites-available/default-ssl /etc/apache2/sites-available/default-ssl.bak
	
	# Set Apache Files
	echo "Copying New Apache Files"
	cp /opt/tds_zombie/etc/confs/apache2/ports.conf /etc/apache2/ports.conf
	cp /opt/tds_zombie/etc/confs/apache2/sites-available/* /etc/apache2/sites-available/
	
	echo "Restarting Apache2 Server"
	/etc/init.d/./apache2 restart
	echo "Starting Kippo SSH HoneyPot..."
	su kippo authbind --deep /opt/kippo/./start.sh
	read -p 'Kippo Should Have Started : Press [Enter] key to continue Installation...' fackEnterKey
	clear
	echo "Installing Required Files for Kippo Graph"
	apt-get install libapache2-mod-php5 php5-mysql php5-gd php5-curl -y
	/etc/init.d/apache2 restart
	cd /opt
	git clone https://github.com/ikoniaris/kippo-graph.git
	echo "Linking WWW"
	ln -s /opt/kippo-graph /opt/tds_zombie/www/kippo-graph
	
}
install_dionaea(){
	clear
	echo "We need to Update your System : "
	apt-get update
	read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
	clear
	echo "We need to Install GIT : "
	apt-get install git -y
	read -p "GIT Installed : Press [Enter] key to continue..." fackEnterKey
	clear
}
install_honeyd(){
	clear
	echo "We need to Update your System : "
	apt-get update
	read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
	clear
	echo "We need to Install GIT : "
	apt-get install git -y
	read -p "GIT Installed : Press [Enter] key to continue..." fackEnterKey
	clear
}
install_conpot(){
	clear
	echo "We need to Update your System : "
	apt-get update
	read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
	clear
}
install_wordpot(){
	clear
	echo "We need to Update your System : "
	apt-get update
	read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
	clear
	
}
install_phoneyc(){
	clear
	echo "We need to Update your System : "
	apt-get update
	read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
	clear
}
install_glastopf(){
	clear
	echo "We need to Update your System : "
	apt-get update
	read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
	clear
}
install_amun(){
	clear
	echo "We need to Update your System : "
	apt-get update
	read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
	clear
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
	echo " HoneyPot is designed to capture certain attacks. We will install a few"
	echo " various honeypots for you to get started on your way... Good Luck..."
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo ' 1. Honeypot Selection : Install Honeypots '
	echo ' 2. Panel Configuration : Setup Panel '
	echo " "
	echo " 0. To Exit"
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
	echo " 1. Install Kippo SSH HoneyPot"
	echo " 2. Install DionaeaFR HoneyPot"
	echo " 3. Install HoneyD HoneyPot"
	echo ' 4. Install Conpot SCADA/ICS HoneyPot'
	echo " 5. Install WordPot Wordpress HoneyPot"
	echo " 6. Install PhoneyC HoneyPot"
	echo " 7. Install Glastopf Web HoneyPot"
	echo " 8. Install Amun Malware HoneyPot"
	echo " "
	echo " 0. To Exit to the Main Menu "
}
# Install Menu
config_menu() {
	clear
	echo " The Dead Squad Zombie HoneyPot System V.1 Alpha "
	echo ' By Digitalized Warfare HTTP://WWW.THEDEADSQUAD.COM'
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " We need to make sure you have all the required files needed to run the"
	echo " Honeypots. This section will first get the most up to date files and"
	echo " then Configure them for you. Feel free to edit them after..."
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " 1. Configure Kippo SSH HoneyPot"
	echo " 2. Configure DionaeaFR HoneyPot"
	echo " 3. Configure HoneyD HoneyPot"
	echo ' 4. Configure Conpot SCADA/ICS HoneyPot'
	echo " 5. Configure WordPot Wordpress HoneyPot"
	echo " 6. Configure PhoneyC HoneyPot"
	echo " 7. Configure Glastopf Web HoneyPot"
	echo " 8. Configure Amun Malware HoneyPot"
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
	read -p " Main Menu Enter choice [ 1 - 2 or 0 ] " menu_choice
	case $menu_choice in
		1) system_install ;;
		2) system_config ;;
		0) exit 0;;
		*) echo -e " ${RED}Error...${STD}" && sleep 2
	esac
}

# Install Menu Options
install_menu_options(){
	local install_choice
	echo " "
	read -p " Install Menu Enter choice [ 1 - 8 or 0 ] " install_choice
	case $install_choice in
		1) install_kippo ;;
		2) install_dionaea ;;
		3) install_honeyd ;;
		4) install_conpot ;;
		5) install_wordpot ;;
		6) install_phoneyc ;;
		7) install_glastopf ;;
		8) install_amun ;;
		0) break;;
		*) echo -e " ${RED}Error...${STD}" && sleep 2
	esac
}

# Install Menu Options
config_menu_options(){
	local config_choice
	echo " "
	read -p " Install Menu Enter choice [ 1 - 8 or 0 ] " config_choice
	case $config_choice in
		1) configure_kippo ;;
		2) configure_dionaea ;;
		3) configure_honeyd ;;
		4) configure_conpot ;;
		5) configure_wordpot ;;
		6) configure_phoneyc ;;
		7) configure_glastopf ;;
		8) configure_amun ;;
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

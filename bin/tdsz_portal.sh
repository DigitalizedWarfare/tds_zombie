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
	echo "We are nexting going to Update your system and install kippo "
	echo "And other packages from thier GIT Repos so we know they are current"
	echo "We will also change apache ports as we may want to run other honeypots"
	echo "on this server instance.............."
	apt-get update&&echo " "&&echo "Repos Updated "&&apt-get upgrade -y&&echo " " &&echo "Base System up todate"&&echo " "&&apt-get dist-upgrade -y&&updatedb&&echo "System is Updated..."
	echo " "
	echo "We need to Install System Files for Kippo ...."
	apt-get install python-dev openssl python-openssl python-pyasn1 python-twisted authbind build-essential libmysqlclient-dev python-pip python-mysqldb mysql-server libcap2-bin -y
	echo " "
	echo "Checking for Kippo Account. Create if needed ....."
	adduser --disabled-login kippo
	echo " "
	echo "Cloning Kippo Git Source : Please Wait ......."
	cd /opt
	git clone https://github.com/desaster/kippo.git
	echo " "
	echo "Setting Up Authbind ...."
	touch /etc/authbind/byport/22
	chown kippo /etc/authbind/byport/22
	chmod 777 /etc/authbind/byport/22
	echo " "
	echo "Adding Kippo Config Files ...."
	mkdir -p /opt/tds_zombie/logs/kippo/
	cp /opt/tds_zombie/etc/confs/kippo/kippo.cfg /opt/kippo/kippo.cfg
	echo " "
	echo "Adding File System to Kippo HoneyPot ...."
	cd /opt/kippo/utils
	./createfs.py > fs.pickle
	echo " "
	echo "Adding Files to File System ..."
	cd ../honeyfs
	cat /etc/passwd > etc/passwd
	cat /etc/hostname > etc/hostname
	cat /etc/hosts > etc/hosts
	cat /proc/cpuinfo > proc/cpuinfo
	cat /proc/meminfo > proc/meminfo
	cat /proc/version > proc/version
	cat /etc/shadow > etc/shadow
	echo " "
	echo "Adding Extra Commands to Honeypot ...."
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
	echo "Copying Files to Backup Folder ..."
	cp /etc/apache2/ports.conf /opt/tdsz_backup/etc/confs/apache2/ports.conf
	cp /etc/apache2/sites-available/* /opt/tdsz_backup/etc/confs/apache2/sites-available/
	
	# Backup and Move Old Files
	echo "Moving Existing Apache Files ..."
	mv /etc/apache2/ports.conf /etc/apache2/ports.conf.bak
	mv /etc/apache2/sites-available/default /etc/apache2/sites-available/default.bak
	mv /etc/apache2/sites-available/default-ssl /etc/apache2/sites-available/default-ssl.bak
	
	# Set Apache Files
	echo "Copying New Apache Files ...."
	cp /opt/tds_zombie/etc/confs/apache2/ports.conf /etc/apache2/ports.conf
	cp /opt/tds_zombie/etc/confs/apache2/sites-available/* /etc/apache2/sites-available/

	#Set Ownership of Kippo Files
	chown -Rv kippo.kippo /opt/kippo
	#Restart Apache2
	echo "Restarting Apache2 Server ...."
	/etc/init.d/./apache2 restart
	echo "Starting Kippo SSH HoneyPot ..."
	su kippo /opt/kippo/./start.sh
	read -p 'Kippo Should Have Started : Press [Enter] key to continue Installation...' fackEnterKey
	clear
	echo "Installing Required Files for Kippo Graph"
	apt-get install libapache2-mod-php5 php5-mysql php5-gd php5-curl -y
	/etc/init.d/apache2 restart
	
	#Install Kippo Graph
	cd /opt
	git clone https://github.com/ikoniaris/kippo-graph.git
	echo "Linking WWW"
	ln -s /opt/kippo-graph /opt/tds_zombie/www/kippo-graph
	cp /opt/tds_zombie/etc/confs/kippo-graph/config.php /opt/kippo-graph/config.php
	#Set Ownership of Kippo Graph Files
	chown -Rv kippo.kippo /opt/kippo-graph
	chmod +w /opt/kippo-graph/generated-graphs
	
	#Install Kippo2Mysql
	cd /opt
	git clone https://github.com/ikoniaris/kippo2mysql
	mv /opt/kippo2mysql/kippo2mysql.pl /opt/kippo2mysql/kippo2mysql.pl.bak
	cp /opt/tds_zombie/etc/confs/kippo2mysql/kippo2mysql.pl /opt/kippo2mysql/kippo2mysql.pl
	
	#Install Kippo-Log2DB
	cd /opt
	mkdir kippo-log2db 
	cd kippo-log2db
	wget http://handlers.sans.org/jclausing/kippo-log2db.pl
	mv /opt/kippo-log2db/kippo-log2db.pl /opt/kippo-log2db/kippo-log2db.pl.bak
	cp /opt/tds_zombie/etc/confs/kippo-log2db/kippo-log2db.pl /opt/kippo-log2db/kippo-log2db.pl
	
	echo " "
	install_dionaea
}
install_dionaea(){
	clear
	echo "We need to Update your System : "
	apt-get update
	read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
	clear
	echo "We need to Install some Python Files : "
	apt-get install python-pip python-netaddr build-essential python-dev -y
	read -p "Now we need to install some PIP Files : Press [Enter] key to continue..." fackEnterKey
	pip install Django
	pip install pygeoip
	pip install django-pagination
	pip install django-tables2
	pip install django-compressor
	pip install django-htmlmin
	pip install django-filter
	echo " "
	read -p "Check Install..." fackEnterKey
	echo "Now we Install Dionaea"
	apt-get install libglib2.0-dev libssl-dev libcurl4-openssl-dev libreadline-dev libsqlite3-dev python-dev libtool automake autoconf build-essential subversion git-core flex bison pkg-config gnuplot -y
	mkdir /opt/dionaea
	mkdir /opt/dionaea/src
	cd /opt/dionaea/src
	
	git clone git://git.carnivore.it/liblcfg.git liblcfg 
	cd liblcfg/code
	autoreconf -v -i 
	./configure --prefix=/opt/dionaea
	make install
	cd ../..
	
	read -p "Check Install..." fackEnterKey
	git clone git://git.carnivore.it/libemu.git libemu
	cd libemu
	autoreconf -v -i
	./configure --prefix=/opt/dionaea
	make install
	cd ..
	
	read -p "Check Install..." fackEnterKey
	git clone https://github.com/tgraf/libnl.git
	cd libnl
	autoreconf -v -i
	export LDFLAGS=-Wl,-rpath,/opt/dionaea/lib
	./configure --prefix=/opt/dionaea
	make
	make install
	cd ..
	
	read -p "Check Install..." fackEnterKey
	mkdir libev
	cd libev
	wget http://dist.schmorp.de/libev/Attic/libev-4.04.tar.gz 
	tar xfz libev-4.04.tar.gz 
	cd libev-4.04
	./configure --prefix=/opt/dionaea 
	make install
	cd ../..
	
	read -p "Check Install..." fackEnterKey
	mkdir python-3.2
	cd python-3.2
	wget http://www.python.org/ftp/python/3.2.2/Python-3.2.2.tgz
	tar xfz Python-3.2.2.tgz
	cd Python-3.2.2/
	./configure --enable-shared --prefix=/opt/dionaea --with-computed-gotos --enable-ipv6 --host=x86_32 LDFLAGS="-Wl,-rpath=/opt/dionaea/lib/ -L/usr/lib/x86_32-linux-gnu/" 
	make 
	make install
	cd ../..
	
	read -p "Check Install..." fackEnterKey
	mkdir cython
	cd cython
	wget http://cython.org/release/Cython-0.15.tar.gz
	tar xfz Cython-0.15.tar.gz
	cd Cython-0.15 
	/opt/dionaea/bin/python3 setup.py install
	cd ../..

	read -p "Check Install..." fackEnterKey
	mkdir /opt/dionaea/src/udns
	cd /opt/dionaea/src/udns
	wget http://www.corpit.ru/mjt/udns/old/udns_0.0.9.tar.gz 
	tar xfz udns_0.0.9.tar.gz 
	cd udns-0.0.9/ 
	./configure 
	make shared
	
	read -p "Check Install..." fackEnterKey
	cp udns.h /opt/dionaea/include/
	cp *.so* /opt/dionaea/lib/ 
	cd /opt/dionaea/lib 
	ln -s libudns.so.0 libudns.so 
	cd /opt/dionaea/src
	
	read -p "Check Install..." fackEnterKey
	mkdir /opt/dionaea/src/libpcap
	cd /opt/dionaea/src/libpcap
	wget http://www.tcpdump.org/release/libpcap-1.1.1.tar.gz
	tar xfz libpcap-1.1.1.tar.gz
	cd libpcap-1.1.1
	./configure -prefix=/opt/dionaea
	make
	make install
	cd ../..
	
	read -p "Check Install..." fackEnterKey
	git clone git://git.carnivore.it/dionaea.git dionaea
	cd dionaea 
	autoreconf -vi
	./configure –with-lcfg-include=/opt/dionaea/include/ \
	–with-lcfg-lib=/opt/dionaea/lib/ \
	–with-python=/opt/dionaea/bin/python3.2 \
	–with-cython-dir=/opt/dionaea/bin \
	–with-udns-include=/opt/dionaea/include/ \
	–with-udns-lib=/opt/dionaea/lib/ \
	–with-emu-include=/opt/dionaea/include/ \
	–with-emu-lib=/opt/dionaea/lib/ \
	–with-gc-include=/usr/include/gc \
	–with-ev-include=/opt/dionaea/include \
	–with-ev-lib=/opt/dionaea/lib \
	–with-nl-include=/opt/dionaea/include \
	–with-nl-lib=/opt/dionaea/lib/ \
	–with-curl-config=/usr/bin/ \
	–with-pcap-include=/opt/dionaea/include \
	–with-pcap-lib=/opt/dionaea/lib/
	make
	make install
	
	read -p "Check Install..." fackEnterKey
	cd /opt/dionaea/bin
	./dionaea -D
	
	read -p "Check Install..." fackEnterKey
	cd /opt/
	wget https://github.com/benjiec/django-tables2-simplefilter/archive/master.zip -O django-tables2-simplefilter.zip
	unzip django-tables2-simplefilter.zip
	mv django-tables2-simplefilter-master/ django-tables2-simplefilter/
	cd django-tables2-simplefilter/
	python setup.py install
	
	read -p "Check Install..." fackEnterKey
	cd /opt/
	git clone https://github.com/bro/pysubnettree.git
	cd pysubnettree/
	python setup.py install
	
	read -p "Check Install..." fackEnterKey
	cd /opt/
	wget http://nodejs.org/dist/v0.8.16/node-v0.8.16.tar.gz
	tar xzvf node-v0.8.16.tar.gz
	cd node-v0.8.16
	./configure
	make
	make install
	
	read -p "Check Install..." fackEnterKey
	npm install -g less
	
	cd /opt/
	wget https://github.com/RootingPuntoEs/DionaeaFR/archive/master.zip -O DionaeaFR.zip
	unzip DionaeaFR.zip
	mv DionaeaFR-master/ DionaeaFR
	
	read -p "Check Install..." fackEnterKey
	cd /opt/
	wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
	wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
	gunzip GeoLiteCity.dat.gz
	gunzip GeoIP.dat.gz
	mv GeoIP.dat DionaeaFR/DionaeaFR/static
	mv GeoLiteCity.dat DionaeaFR/DionaeaFR/static
	
	read -p "Check Install..." fackEnterKey
	apt-get install python-pip python-netaddr
	apt-get install unzip sqlite
	
	read -p "DionaeaFR Installed : Press [Enter] key to continue..." fackEnterKey
	cd /opt/DionaeaFR/
	python manage.py collectstatic #type yes when asked
	python manage.py runserver 0.0.0.0:8000
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
	read -p " Main Menu Enter choice [ 1 or 0 ] " menu_choice
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

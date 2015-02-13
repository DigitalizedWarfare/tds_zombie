#!/bin/bash

clear
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo " The Dead Squad Zombie HoneyPot System V.1 Alpha "
echo ' By Digitalized Warfare for HTTP://WWW.THEDEADSQUAD.COM'
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo " This software will install Conpot Honeypot on your system. Each"
echo " HoneyPot is designed to capture certain attacks. We will install a few"
echo " various honeypots for you to get started on your way... Good Luck..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	
apt-get update
echo ""
echo "Next we install some packages"
apt-get install git libsmi2ldbl smistrip libxslt1-dev python-dev libevent-dev -y
	
#deb http://ftp.nl.debian.org/debian squeeze main non-free
apt-get update
apt-get install snmp-mibs-downloader -y
cd /opt
git clone https://github.com/glastopf/modbus-tk.git
cd modbus-tk
python setup.py install
cd ..
git clone https://github.com/glastopf/conpot.git
cd conpot
python setup.py install
	
read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
clear
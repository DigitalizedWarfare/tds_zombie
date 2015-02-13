#!/bin/bash

clear
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo " The Dead Squad Zombie HoneyPot System V.1 Alpha "
echo ' By Digitalized Warfare for HTTP://WWW.THEDEADSQUAD.COM'
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo " This software will install multiple honeypots on your system. Each"
echo " HoneyPot is designed to capture certain attacks. We will install a few"
echo " various honeypots for you to get started on your way... Good Luck..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	
apt-get update
read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
clear
echo "We need to Install some Packages : "
apt-get install libevent-dev libdumbnet-dev libpcap-dev libpcre3-dev libedit-dev bison flex libtool automake -y
read -p "GIT Installed : Press [Enter] key to continue..." fackEnterKey
echo ""
echo "Next we need to Clone Git Source"
cd /opt
git clone https://github.com/DataSoft/Honeyd.git
cd Honeyd
./autogen.sh
./configure
make
make install
clear
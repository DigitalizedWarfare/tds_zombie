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
cd /opt
git clone https://github.com/gbrindisi/wordpot.git
	
read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
clear
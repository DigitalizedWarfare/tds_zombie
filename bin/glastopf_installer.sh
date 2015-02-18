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
apt-get install python-mysqldb -y
pip install --upgrade greenlet
apt-get update
apt-get install python python-openssl python-gevent libevent-dev python-dev build-essential make -y
apt-get install python-argparse python-chardet python-requests python-sqlalchemy python-lxml -y
apt-get install python-beautifulsoup mongodb python-pip python-dev python-setuptools -y
apt-get install g++ git php5 php5-dev liblapack-dev gfortran -y
apt-get install libxml2-dev libxslt-dev -y
apt-get install libmysqlclient-dev -y
pip install --upgrade distribute
	
cd /opt
git clone git://github.com/glastopf/BFR.git
cd BFR
phpize
./configure --enable-bfr
make &&  make install
	
#Into Php.ini zend_extension = /usr/lib/php5/20100525/bfr.so

cd /opt
git clone https://github.com/glastopf/glastopf.git
git clone https://github.com/client9/libinjection.git
git clone https://github.com/glastopf/pylibinjection.git
cd glastopf
python setup.py install
	
cd /opt
mkdir zombiebox
cd zombiebox
#glastopf-runner
	
read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
clear
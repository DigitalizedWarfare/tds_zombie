#!/bin/bash

clear
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo " The Dead Squad Zombie HoneyPot System V.1 Alpha "
echo ' By Digitalized Warfare for HTTP://WWW.THEDEADSQUAD.COM'
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo " This software will install Dionaea Honeypot on your system. Each"
echo " HoneyPot is designed to capture certain attacks. We will install a few"
echo " various honeypots for you to get started on your way... Good Luck..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	
apt-get update
#read -p "System Updated : Press [Enter] key to continue..." fackEnterKey
clear
echo "We need to Install some Python Files : "
apt-get install python-pip python-netaddr build-essential python-dev -y
#read -p "Now we need to install some PIP Files : Press [Enter] key to continue..." fackEnterKey
pip install Django
pip install pygeoip
pip install django-pagination
pip install django-tables2
pip install django-compressor
pip install django-htmlmin
pip install django-filter
echo " "
#read -p "Check Install..." fackEnterKey
echo "Now we Install Dionaea"
apt-get install libglib2.0-dev libssl-dev libcurl4-openssl-dev libreadline-dev libsqlite3-dev python-dev libtool automake autoconf build-essential subversion git-core flex bison pkg-config gnuplot -y
mkdir /opt/dionaea
mkdir /opt/dionaea/src
cd /opt/dionaea/src
	
#read -p "Check Install..." fackEnterKey
git clone git://git.carnivore.it/liblcfg.git liblcfg 
cd liblcfg/code
autoreconf -v -i 
./configure --prefix=/opt/dionaea
make install
cd ../..
	
#read -p "Check Install..." fackEnterKey
git clone git://git.carnivore.it/libemu.git libemu
cd libemu
autoreconf -v -i
./configure --prefix=/opt/dionaea
make install
cd ..
	
#read -p "Check Install..." fackEnterKey
git clone https://github.com/tgraf/libnl.git
cd libnl
autoreconf -v -i
export LDFLAGS=-Wl,-rpath,/opt/dionaea/lib
./configure --prefix=/opt/dionaea
make
make install
cd ..
	
#read -p "Check Install..." fackEnterKey
mkdir libev
cd libev
wget http://dist.schmorp.de/libev/Attic/libev-4.04.tar.gz 
tar xfz libev-4.04.tar.gz 
cd libev-4.04
./configure --prefix=/opt/dionaea 
make install
cd ../..
	
#read -p "Check Install..." fackEnterKey
mkdir python-3.2
cd python-3.2
wget http://www.python.org/ftp/python/3.2.2/Python-3.2.2.tgz
tar xfz Python-3.2.2.tgz
cd Python-3.2.2/
./configure --enable-shared --prefix=/opt/dionaea --with-computed-gotos --enable-ipv6 --host=x86_32 LDFLAGS="-Wl,-rpath=/opt/dionaea/lib/ -L/usr/lib/x86_32-linux-gnu/" 
make 
make install
cd ../..
	
#read -p "Check Install..." fackEnterKey
mkdir cython
cd cython
wget http://cython.org/release/Cython-0.15.tar.gz
tar xfz Cython-0.15.tar.gz
cd Cython-0.15 
/opt/dionaea/bin/python3 setup.py install
cd ../..

#read -p "Check Install..." fackEnterKey
mkdir /opt/dionaea/src/udns
cd /opt/dionaea/src/udns
wget http://www.corpit.ru/mjt/udns/old/udns_0.0.9.tar.gz 
tar xfz udns_0.0.9.tar.gz 
cd udns-0.0.9/ 
./configure 
make shared
	
#read -p "Check Install..." fackEnterKey
cp udns.h /opt/dionaea/include/
cp *.so* /opt/dionaea/lib/ 
cd /opt/dionaea/lib 
ln -s libudns.so.0 libudns.so 
cd /opt/dionaea/src
	
#read -p "Check Install..." fackEnterKey
mkdir /opt/dionaea/src/libpcap
cd /opt/dionaea/src/libpcap
wget http://www.tcpdump.org/release/libpcap-1.1.1.tar.gz
tar xfz libpcap-1.1.1.tar.gz
cd libpcap-1.1.1
./configure -prefix=/opt/dionaea
make
make install
cd ../..
	
#read -p "Check Install..." fackEnterKey
git clone git://git.carnivore.it/dionaea.git dionaea
cd dionaea 
autoreconf -v -i
./configure --with-lcfg-include=/opt/dionaea/include/ \
--with-lcfg-lib=/opt/dionaea/lib/ \
--with-python=/opt/dionaea/bin/python3.2 \
--with-cython-dir=/opt/dionaea/bin \
--with-udns-include=/opt/dionaea/include/ \
--with-udns-lib=/opt/dionaea/lib/ \
--with-emu-include=/opt/dionaea/include/ \
--with-emu-lib=/opt/dionaea/lib/ \
--with-gc-include=/usr/include/gc \
--with-ev-include=/opt/dionaea/include \
--with-ev-lib=/opt/dionaea/lib \
--with-nl-include=/opt/dionaea/include \
--with-nl-lib=/opt/dionaea/lib/ \
--with-curl-config=/usr/bin/ \
--with-pcap-include=/opt/dionaea/include \
--with-pcap-lib=/opt/dionaea/lib/
make
make install
	
#read -p "Check Install..." fackEnterKey
cd /opt/
git clone  https://github.com/benjiec/django-tables2-simplefilter
cd django-tables2-simplefilter/
python setup.py install
	
#read -p "Check Install..." fackEnterKey
cd /opt/
git clone https://github.com/bro/pysubnettree.git
cd pysubnettree/
python setup.py install
	
#read -p "Check Install..." fackEnterKey
cd /opt/
#wget http://nodejs.org/dist/v0.8.16/node-v0.8.16.tar.gz
wget http://nodejs.org/dist/v0.10.33/node-v0.10.33.tar.gz
tar xzvf node-v0.10.33.tar.gz
cd node-v0.10.33
./configure
make
make install
	
#read -p "Check Install..." fackEnterKey
npm install -g less
	
cd /opt/
git clone https://github.com/rubenespadas/DionaeaFR.git
#unzip DionaeaFR.zip
#mv DionaeaFR-master/ DionaeaFR
	
#read -p "Check Install..." fackEnterKey
cd /opt/
wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
gunzip GeoLiteCity.dat.gz
gunzip GeoIP.dat.gz
mv GeoIP.dat DionaeaFR/DionaeaFR/static
mv GeoLiteCity.dat DionaeaFR/DionaeaFR/static
	
#read -p "Check Install..." fackEnterKey
apt-get install python-pip python-netaddr -y
apt-get install unzip sqlite p0f -y
	
#read -p "Check Install..." fackEnterKey
mv /opt/dionaea/etc/dionaea/dionaea.conf /opt/dionaea/etc/dionaea/dionaea.conf.bak
cp /opt/tds_zombie/etc/confs/dionaea/dionaea.conf /opt/dionaea/etc/dionaea/dionaea.conf
cd /opt/dionaea/bin
#p0f -i any -u root -Q /tmp/p0f.sock -q -l&
#./dionaea -D

cp /opt/tds_zombie/etc/confs/dionaeafr/settings.py /opt/DionaeaFR/DionaeaFR/settings.py
#read -p "DionaeaFR Installed : Press [Enter] key to continue..." fackEnterKey
cd /opt/DionaeaFR/
mkdir -p /var/run/dionaeafr/
#python manage.py collectstatic #type yes when asked
#python manage.py migrate
#screen -a -m -d -S DioneaeFR python manage.py runserver 0.0.0.0:8000
read -p "DionaeaFR Installed : Press [Enter] key to continue..." fackEnterKey
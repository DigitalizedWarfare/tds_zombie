#!/bin/bash

clear
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo " The Dead Squad Zombie HoneyPot System V.1 Alpha "
echo ' By Digitalized Warfare for HTTP://WWW.THEDEADSQUAD.COM'
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo " This software will install Kippo SSH Honeypot on your system. This "
echo " HoneyPot is designed to capture SSH attacks. We will install the base"
echo " Honeyport plus the Browers Stats for you to get started on your way... "
echo ' URL for stats and graphs..  http://public-ip-here:15080 Good Luck...'
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo " "
read -p " Press [Enter] key to continue ...." fackEnterKey

# Apt Update to make sure system is fresh. 
echo ""
echo " We are going to Update your System ...."	
apt-get update&&echo " "&&echo "Repos Updated "&&apt-get upgrade -y&&echo " " &&echo "Base System up todate"&&echo " "&&apt-get dist-upgrade -y&&updatedb&&echo "System is Updated..."
echo " "
read -p " Press [Enter] key to continue ...." fackEnterKey

# Must Install These Files
echo " "
echo "We need to Install System Files for Kippo ...."
apt-get install python-dev openssl python-openssl python-pyasn1 python-twisted authbind build-essential libmysqlclient-dev python-pip python-mysqldb mysql-server libcap2-bin -y

# We ned to change the Mysql Port se we can run other Honeypots on same ip address.
echo " "
echo " Stopping MYSQL Server, and reconfiguring Ports ...."
/etc/init.d/./mysql stop
rm -rf /etc/mysql/my.cnf.bak
mv /etc/mysql/my.cnf /etc/mysql/my.cnf.bak
cp /opt/tds_zombie/etc/confs/mysql/my.cnf /etc/mysql/my.cnf
echo " Starting Mysql Server ...."
/etc/init.d/./mysql start

# Kippo needs a User Account to run. Not as Root.	
echo " "
echo "Creating Kippo User Account ...."
#adduser --disabled-login kippo

read -p " Enter Your Root Password for MySql " mysql_password
/usr/bin/expect /opt/tds_zombie/bin/system_useradd.exp kippo TheDeadSquad 
/usr/bin/expect /opt/tds_zombie/bin/system_import_kipposql.exp kippo TheDeadSquad $mysql_password

# We Need LATEST Build
echo " "
echo "Getting Latest Kippo from GITHUB ...."
cd /opt
git clone https://github.com/desaster/kippo.git

# Authbind is required to access ports below 1024. These are considered restricted.
echo " "
echo "Setting Up Authbind For restricted port access ...."
touch /etc/authbind/byport/22
chown kippo /etc/authbind/byport/22
chmod 777 /etc/authbind/byport/22

# We need to Copy our PRE Filled Config file in place.
echo " "
echo "Moving Kippo Config File ...."
mkdir -p /opt/tds_zombie/logs/kippo/
cp /opt/tds_zombie/etc/confs/kippo/kippo.cfg /opt/kippo/kippo.cfg

setcap 'cap_net_bind_service=+ep' /usr/bin/python2.7

# PhpMyAdmin for the User access to Database
echo " "
echo " Installing PhpMyAdmin ..."
apt-get install phpmyadmin -y
mv /etc/phpmyadmin/config-db.php /etc/phpmyadmin/config-db.php.bak
cp /opt/tds_zombie/etc/confs/phpmyadmin/config-db.php /etc/phpmyadmin/config-db.php

#Need for phpliteadmin
apt-get install php5-sqlite -y

# We need to create back configs folders
echo " "
echo " Creating Backup Folders for Apache ..."	
mkdir -p /opt/tdsz_backup/etc/confs/apache2/sites-available/
mkdir -p /opt/tdsz_backup/etc/confs/apache2/sites-available/sites-enabled

#enable Mod Rewrite
a2enmod rewrite
mkdir -p /opt/tds_zombie/logs/apache2/
	
# We need to Backup the configs and Ports
#echo "Copying Files to Backup Folder ..."
#cp /etc/apache2/ports.conf /opt/tdsz_backup/etc/confs/apache2/ports.conf
#cp /etc/apache2/sites-available/* /opt/tdsz_backup/etc/confs/apache2/sites-available/
	
# Move exiting Files, and Copy our pre-configured files in place
echo "Moving Existing Apache Files ..."
mv /etc/apache2/ports.conf /opt/tdsz_backup/etc/confs/apache2/ports.conf.bak
mv /etc/apache2/sites-available/default /opt/tdsz_backup/etc/confs/apache2/sites-available/default.bak
mv /etc/apache2/sites-available/default-ssl /opt/tdsz_backup/etc/confs/apache2/sites-available/default-ssl.bak
	
# Now Place Our Files in place
echo "Copying New Apache Files ...."
cp /opt/tds_zombie/etc/confs/apache2/ports.conf /etc/apache2/ports.conf
cp /opt/tds_zombie/etc/confs/apache2/sites-available/* /etc/apache2/sites-available/

#Restart Apache2 Web Server to pick up changes..
echo "Restarting Apache2 Server ...."
/etc/init.d/./apache2 restart

# Install software for Kippo Graph
echo " "
echo "Installing Required Files for Kippo Graph"
apt-get install libapache2-mod-php5 php5-mysql php5-gd php5-curl screen -y
/etc/init.d/apache2 restart
	
#Install Kippo Graph
echo " "
echo " Getting Kippo-Graph source from GITHUB ..."
cd /opt
git clone https://github.com/ikoniaris/kippo-graph.git

# Create Symbolic Links 
echo " "
echo "Creating Links in WWW Folder ..."
ln -s /opt/kippo-graph /opt/tds_zombie/www/kippo-graph
cp /opt/tds_zombie/etc/confs/kippo-graph/config.php /opt/kippo-graph/config.php
#Set Ownership of Kippo Graph Files
chown -Rv kippo.kippo /opt/kippo-graph
chmod -Rv 777 /opt/kippo-graph/generated-graphs
	
#Install Kippo2Mysql
echo " "
echo " Installing Kippo2Mysql ..."
cd /opt
git clone https://github.com/ikoniaris/kippo2mysql
mv /opt/kippo2mysql/kippo2mysql.pl /opt/kippo2mysql/kippo2mysql.pl.bak
cp /opt/tds_zombie/etc/confs/kippo2mysql/kippo2mysql.pl /opt/kippo2mysql/kippo2mysql.pl
	
#Install Kippo-Log2DB
echo " "
echo " Installing Kippo-Log2db ..."
cd /opt
mkdir kippo-log2db 
cd kippo-log2db
wget http://handlers.sans.org/jclausing/kippo-log2db.pl
mv /opt/kippo-log2db/kippo-log2db.pl /opt/kippo-log2db/kippo-log2db.pl.bak
cp /opt/tds_zombie/etc/confs/kippo-log2db/kippo-log2db.pl /opt/kippo-log2db/kippo-log2db.pl

# This will generate a filesystem on the honeypot from our current.
echo " "
echo "Adding File System to Kippo HoneyPot. May take a while ...."
cd /opt/kippo/utils
./createfs.py > fs.pickle

# We need to populate the kippo system
echo " "
echo "Adding Local Files to Kippo File System ...."
cd ../honeyfs
cat /etc/passwd > /opt/kippo/honeyfs/etc/passwd
echo "archives" > /opt/kippo/honeyfs/etc/hostname
cat /opt/tds_zombie/etc/confs/kippo/honeyfs/etc/hosts > /opt/kippo/honeyfs/etc/hosts
cat /proc/cpuinfo > /opt/kippo/honeyfs/proc/cpuinfo
cat /proc/meminfo > /opt/kippo/honeyfs/proc/meminfo
cat /proc/version > /opt/kippo/honeyfs/proc/version
cat /etc/shadow > /opt/kippo/honeyfs/etc/shadow

# We need to add some commands to kippo to make it feel more real.
echo " "
echo "Adding some Extra Commands to Kippo Honeypot ...."
cd ../txtcmds
df > bin/df
dmesg > bin/dmesg
mount > bin/mount
ulimit > bin/ulimit
perl -v > bin/perl
ifconfig > sbin/ifconfig
php -v > bin/php
php5 -v > bin/php5
python --version > bin/python

#Set Ownership of Kippo Files
echo " Changing File Owner to Kippo ..."
chown -Rv kippo.kippo /opt/kippo

# Copy Files to Backup Folder
echo "Starting Kippo SSH HoneyPot ..."
#su kippo /opt/kippo/./start.sh

# Show Closing Menu
echo " "
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo " This software will install Kippo SSH Honeypot on your system. This "
echo " HoneyPot is designed to capture SSH attacks. We will install the base"
echo " Honeyport plus the Browers Stats for you to get started on your way... "
echo ' URL for stats and graphs..  http://public-ip-here:15080 Good Luck...'
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo " "
read -p " Installation Done.... Press [Enter] key to continue ...." fackEnterKey
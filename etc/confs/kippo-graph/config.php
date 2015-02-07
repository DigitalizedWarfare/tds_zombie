﻿<?php
# Author: ikoniaris
# Website: bruteforce.gr/kippo-graph

# DIR_ROOT: defines where your Kippo-Graph installation currently resides in.
# Please don't change this unless there is a special reason to do so.
define('DIR_ROOT', dirname(__FILE__));

# Language selection for charts -- Default: en (English)
# Change the two-letter lang.XX.php language code to your preferred choice.
# Available options:
#  en: English | fr: French | de: German | it: Italian | es: Spanish
#  nl: Dutch | el: Greek | et: Estonian | pl: Polish | sv: Swedish
#  cs: Czech | sk: Slovak | ar: Arabic (currently not working)
require_once(DIR_ROOT . '/include/languages/lang.en.php');

# MySQL server configuration: you will have to change the following
# four definitions from the default values to the correct ones,
# according to your MySQL server instance. When you installed Kippo
# and configured MySQL logging, you should have created a new
# MySQL user just for this job, otherwise use root (not recommended!)
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', 'TheDeadSquad');
define('DB_NAME', 'kippo');
define('DB_PORT', '3306');

# Which geolocation method should be used -- Default: LOCAL (MaxMind)
# Note: LOCAL (MaxMind) enables additional fields in various components.
#  When using LOCAL you might want to periodically update (monthly) the
#  kippo-graph/include/maxmind/GeoLite2-City.mmdb MaxMind database file
#  with a new one from: http://dev.maxmind.com/geoip/geoip2/geolite2/
# Available options:
#  LOCAL: fastest, uses a local MaxMind GeoLite2 database
#  GEOPLUGIN: uses the geoplugin.com web service (online)
define('GEO_METHOD', 'LOCAL');

# Check if logged IP addresses are coming from Tor using the Tor Bulk Exit List exporting tool.
# The list of exit nodes is also saved locally, in case the online service goes down.
# Note: this enables additional fields in various components.
# Change NO to YES if you want to enable it.
define('TOR_CHECK', 'NO');

# The following value determines whether Kippo-Graph will
# automatically check if a newer version is available for download.
# You can inspect the function at kippo-graph/include/misc/versionCheck.php.
# It works by comparing the latest version number that resides
# in a text file uploaded on Kippo-Graph's website against the
# 'VERSION' definition inside versionCheck.php. While in theory you can
# trust the remote website, I realise that you might think that this check
# poses a risk to the privacy of your honeypot's IP address.
# For this reason, the following value ensures that having the
# update checking feature enabled is your choice and not forced.
# Change NO to YES if you want to enable it.
define('UPDATE_CHECK', 'NO');

# The following value determines the minimum size (in kb) of the Kippo log needed to be
# shown in Kippo-Playlog. Any value below it will be ignored.
# This is useful to remove any sessions that just join and quit immediately afterwards.
# The value may need tweaking based on the length of the MOTD (displayed after a successful login).
define('PLAYBACKSIZE_IGNORE', '0.4');

?>

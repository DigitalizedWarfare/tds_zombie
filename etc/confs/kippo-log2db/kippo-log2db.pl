#!/usr/bin/perl
#
# Name:    kippo-log2db.pl
# Author:  Jim Clausing
# Date:    2014-03-18
# Version: 0.8.1
#
# This script was inspired by kippo2mysql by Ioannis “Ion” Koniaris
# (bruteforce.gr/kippo2mysql) which I really liked, but that script 
# while populating a MySQL database, was not populating the actual 
# kippo schema, so I wrote this script.  This can be useful for anyone 
# who started logging to files and now wishes to switch to logging 
# to MySQL, but doesn't want to lose old data.  It could also be 
# useful if the sensor is a lightweight VM or remote from the DB and 
# you don't need real-time updaes to the DB, the logs compress very 
# nicely and can be rsync-ed to the system where the DB resides.
#
# Send any feedback to me at jclausing@isc.sans.edu or handlers@sans.edu.
# 
# This file is distributed under the terms of GPLv3.
#

#use strict;
#use warnings; #enable for debugging
use DBI;

my (%start, %end, %sensor, %sensors, %ip, %termsize, %client) = ();

#Paths to various kippo components - change accordingly!
#
#Root/config directory
my $kipporootdir = '/opt/kippo';
#Log directory
my $kippologdir = '/opt/kippo/log';

my $cnt = 0; 

#MySQL server values - change accordingly!
$sql_user = 'root';
$sql_password = 'TheDeadSquad';
$database = 'kippolog2db';
$hostname = 'localhost';
$port = '53306';

#Connect to the database
$dbh = DBI->connect("dbi:mysql:database=$database;host=$hostname;port=$port", $sql_user, $sql_password);

$auth_insert = "INSERT INTO auth (session, success, username, password, timestamp) VALUES (?,?,?,?,?)";
$clients_insert = "INSERT INTO clients (version) VALUES (?)";
$dl_insert = "INSERT INTO downloads VALUES (DEFAULT,?,?,?,?)";
$input_insert = "INSERT INTO input (session, timestamp, realm, success, input) VALUES (?,?,?,?,?)";
$sensors_insert = "INSERT INTO sensors (ip) VALUES (?)";
$sessions_insert = "INSERT INTO sessions (id, starttime, endtime, sensor, ip, termsize, client) VALUES (?,?,?,?,?,?,?)";
$ttylog_insert = "INSERT INTO ttylog (session, ttylog) VALUES (?,?)";

$client_query = "SELECT id FROM clients WHERE version = ?";

$sth_auth_ins = $dbh->prepare($auth_insert);
$sth_clnt_ins = $dbh->prepare($clients_insert);
$sth_dnld_ins = $dbh->prepare($dl_insert);
$sth_inpt_ins = $dbh->prepare($input_insert);
$sth_snsr_ins = $dbh->prepare($sensors_insert);
$sth_sess_ins = $dbh->prepare($sessions_insert);
$sth_ttyl_ins = $dbh->prepare($ttylog_insert);

$sth_clnt_qry = $dbh->prepare($client_query);

print "$0

This script will parse all the kippo logs in a directory (from oldest to newest) and
populate a MySQL database using the same schema as if the kippo sensor were logging
directly to MySQL.

This could take some time to complete.
";

#Start parsing Kippo log files...
chdir $kippologdir;
@files = `ls -1rt kippo.log*`;
foreach $file (@files) {
  open (IN, $file) || die "Can't open log stream: $!\n";
  print "\n$file\n";
  while (<IN>) {
    chomp;
    $| = 1;
    print "#" if $cnt++%10000;
# 2014-02-14 00:24:13-0500 [kippo.core.honeypot.HoneyPotSSHFactory] New connection: 218.2.22.110:1537 (xx.xx.xx.xx:xx) [session: 201235]
    if (/^(\S+ \S+) \S+ New connection: (.*?):\d+ \((\S+):\d+\) \[session: (\d+)\]$/) { 
	$start{$4} = $1;
	$sensor{$4} = $3;
	if (!defined $sensors{$3}) {
	    $sth_snsr_ins->execute($3);
	};
	$sensors{$3}++;
	$ip{$4} = $2;
    };
# 2014-02-14 00:24:14-0500 [HoneyPotTransport,201235,218.2.22.110] Remote SSH version: SSH-2.0-libssh2_1.4.2
    if (/\[HoneyPotTransport,(\d+),\S+ Remote SSH version:\s+(.*?)$/) {
	$sth_clnt_qry->execute($2);
	my @id;
	@id = $sth_clnt_qry->fetchrow_array;
	if (!defined $id[0]) {
	    $sth_clnt_ins->execute($2);
	}
	$sth_clnt_qry->execute($2);
	@id = $sth_clnt_qry->fetchrow_array;
	$client{$1} = $id[0];
    };
# 2013-12-17 10:43:06-0500 [SSHService ssh-userauth on HoneyPotTransport,150308,113.162.157.137] login attempt [support/support] failed
    if (/^(\S+ \S+) \[SSHService ssh-userauth on HoneyPotTransport,(\S+),\d+\.\d+\.\d+\.\d+\] login attempt \[(.*?)\/(.*?)\] (\S+)$/) { 
	$sth_auth_ins->execute($2, $5, $3, $4, $1);
    };
# 2014-02-14 08:55:49-0500 [SSHChannel session (0) on SSHService ssh-connection on HoneyPotTransport,201280,199.227.127.54] Terminal size: 24 80
    if (/HoneyPotTransport,(\d+),\S+ Terminal size: (\d+) (\d+)$/) {
	$termsize{$1} = $3 . "x" . $2;
    };
# 2014-02-14 00:24:13-0500 [HoneyPotTransport,201234,218.2.22.110] connection lost
    if (/^(\S+ \S+) \[HoneyPotTransport,(\d+),\d+\.\d+\.\d+\.\d+\] connection lost/) {
	$end{$2} = $1;
	$sth_sess_ins->execute($2, $start{$2}, $end{$2}, $sensor{$2}, $ip{$2}, (defined $termsize{$2}?$termsize:NULL), $client{$2});
    };
# 2014-02-14 08:55:49-0500 [SSHChannel session (0) on SSHService ssh-connection on HoneyPotTransport,201280,199.227.127.54] Opening TTY log: log/tty/20140214-085549-9688.log
    if (/HoneyPotTransport,(\d+),\d+\.\d+\.\d+\.\d+\] Opening TTY log: (\S+)$/) {
	open my $fh, '<', "$kipporootdir/$2" or die "error opening $2: $!";
	my $data = do { local $/; <$fh> };
	close $fh;
	$sth_ttyl_ins->execute($1,$data);
        $data = undef;
    };
# 2014-02-08 08:23:40-0500 [SSHChannel session (0) on SSHService ssh-connection on HoneyPotTransport,197902,67.200.156.243] Starting factory <HTTPProgressDownloader: http://downloads.sourceforge.net/sqlmap/sqlmap-0.9.tar.gz>
# 2014-02-08 08:23:42-0500 [HTTPPageDownloader,client] Updating realfile to dl/20140208082340_http___downloads_sourceforge_net_sqlmap_sqlmap_0_9_tar_gz
    if (/^(\S+ \S+) .* HoneyPotTransport,(\d+),\d+\.\d+\.\d+\.\d+\] Starting factory \S+\s?: (.+)\>$/) {
    #if (/^(\S+ \S+) \[SSHChannel session \(\d+\) on SSHService ssh-connection on HoneyPotTransport,(\d+),\d+\.\d+\.\d+\.\d+\] Starting factory \<HTTPProgressDownloader : (\S+)\>/) {
	my $ts = $1;
	my $sess = $2;
	my $url = $3;
	my ($yr,$mo,$dy,$hr,$mn,$sc) = $ts =~ /(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})-\d{4}/;
	my $fn = $url;
	$fn =~ tr/:\/\.\?=-/_/;
	$fn = sprintf("dl/%04d%02d%02d%02d%02d%02d_%s",$yr,$mo,$dy,$hr,$mn,$sc,$fn);
	$sth_dnld_ins->execute($sess,$ts,$url,$fn);
    };
# 2012-07-02 21:08:43-0400 [SSHChannel session (0) on SSHService ssh-connection on HoneyPotTransport,10627,31.188.4.145] INPUT (passwd): alin77ja77
    if (/^(\S+ \S+) .* HoneyPotTransport,(\d+),\d+\.\d+\.\d+\.\d+\] INPUT \((\S+)\): (.+)$/) {
	$sth_inpt_ins->execute($2,$1,$3,NULL,$4);
    };
# 2013-12-17 09:20:42-0500 [SSHChannel session (0) on SSHService ssh-connection on HoneyPotTransport,150306,91.121.145.59] INPUT: nmap
    if (/^(\S+ \S+) .* HoneyPotTransport,(\d+),\d+\.\d+\.\d+\.\d+\] INPUT: (.+)$/) {
	$sth_inpt_ins->execute($2,$1,NULL,NULL,$3);
    };
# 2012-07-02 21:08:32-0400 [SSHChannel session (0) on SSHService ssh-connection on HoneyPotTransport,10627,31.188.4.145] Command found: w
    if (/^(\S+ \S+) .* HoneyPotTransport,(\d+),\d+\.\d+\.\d+\.\d+\] Command found: (.+)$/) {
	$sth_inpt_ins->execute($2,$1,NULL,1,$3);
    };
# 2013-12-17 09:20:31-0500 [SSHChannel session (0) on SSHService ssh-connection on HoneyPotTransport,150306,91.121.145.59] Command not found: yum
    if (/^(\S+ \S+) .* HoneyPotTransport,(\d+),\d+\.\d+\.\d+\.\d+\] Command not found: (.+)$/) {
	$sth_inpt_ins->execute($2,$1,NULL,0,$3);
    };
  }
  close (IN);
}

print "--------------------------------------------------------------\n\n"; 
print "$date stats for kippo instance\nInstance $sensorid\nUnique values ($connections connections):\n - usernames\t" , scalar keys %usernames , "\n - passwords\t" , scalar keys %passwords , "\n - sources\t" , scalar keys %sources , "\n";
print "--------------------------------------------------------------\n";

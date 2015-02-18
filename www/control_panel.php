<?php

#Kippo 
$kippo_pid=file_get_contents('/opt/kippo/kippo.pid');
#dionaea
$dionaea_pid=file_get_contents('/run/dionaeafr/dionaeafr.pid');
#WordPot 
$wordpot_pid=file_get_contents('/opt/kippo/kippo.pid');
#ConPot 
$conpot_pid=file_get_contents('/opt/kippo/kippo.pid');
#HoneyD 
$honeyd_pid=file_get_contents('/opt/kippo/kippo.pid');
#PhoneyC 
$phoneyc_pid=file_get_contents('/opt/kippo/kippo.pid');
#Glastopf
$glastopf_pid=file_get_contents('/opt/kippo/kippo.pid');
#Amun 
$amun_pid=file_get_contents('/opt/kippo/kippo.pid');

if($_GET['HoneyPot'] =='kippo' && $_GET['Action'] == 'start') {
shell_exec('su kippo /opt/kippo/./start.sh');

}elseif($_GET['HoneyPot'] =='kippo' && $_GET['Action'] == 'stop') {
shell_exec('/opt/kippo/./stop.sh');

}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>The Dead Squad Honeypot System</title>
		<link href="css/style.css" rel="stylesheet" type="text/css" />
		
	</head>
	<body>
		<div id="wrapper">
  	 		<div id="branding">
  	 			<h1 class="logo"><a href="#" title="&lt; The Dead Squad Zombie Panel &gt;">&lt;  /&gt;</a></h1>
   				<ul class="topNav">
	    				<li><a href="index.html">Home Page</a></li>
					<li><a href="control_panel.html" class="topNavAct">Control Panel</a></li>
					<li><a href="kippo_config.html">Kippo</a></li>
					<li><a href="dionaea_config.html">Dionaea</a></li>
					<li><a href="wordpot_config.html">WordPot</a></li>
					<li><a href="conpot_config.html">ConPot</a></li>
					<li><a href="honeyd_config.html">HoneyD</a></li>
					<li><a href="phoneyc_config.html">PhoneyC</a></li>
					<li><a href="glastopf_config.html">Glastopf</a></li>
					<li><a href="amun_config.html">Amun</a></li>
					<li><a href="phpmyadmin/" target="_blank" class="topNavLast">PhpMyAdmin</a></li>
	  			</ul>
	  			<br class="clear" />
   			</div>
   			<div id="contant">
				<div id="builder">
    					<div class="builderForm">
						<p>Welcome to the Kippo SSH Honeypot confitg builder. Here are a few things that you want to edit
						Some Honeypots have more then one config. You will need to restart the service for your changes to take
						effect.
						</p>
	  					<br class="clear" />
	  				</div>
					<div class="builderFormMenu">
					<font color="#4a4a4a" style="font-size: 12px;">			 	
						<table>
							<thead>
								<tr>
									<th>HoneyPot Name</th>
									<th>Status</th>
									<th>Start</th>
									<th>Stop</th>
									<th>Configure</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="5">Services May have to be restarted after edit.</td>
									
								</tr>
							</tfoot>
							<tbody>
								<tr>
									<td><b>Kippo Honeypot</b></td>
									<td><?php if($kippo_pid !='') { echo '<img src="images/up.png"'; } else { echo '<img src="images/error.png"'; } ?> class="displayed" /></td>
									<td><a href=""><img src="images/up.png" class="displayed" /></a></td>
									<td><a href=""><img src="images/error.png" class="displayed" /></a></td>
									<td><a href="kippo_config.html"><img src="images/file.png" class="displayed" /></a></td>
								</tr>
								<tr>
									<td>Dionaea Honeypot</td>
									<td><?php if($dionaea_pid !='') { echo '<img src="images/up.png"'; } else { echo '<img src="images/error.png"'; } ?> class="displayed" /></td>
									<td><a href=""><img src="images/up.png" class="displayed" /></a></td>
									<td><a href=""><img src="images/error.png" class="displayed" /></a></td>
									<td><a href="dionaea_config.html"><img src="images/file.png" class="displayed" /></a></td>
								</tr>
								<tr>
									<td>Wordpot Honeypot</td>
									<td><?php if($wordpot_pid !='') { echo '<img src="images/up.png"'; } else { echo '<img src="images/error.png"'; } ?> class="displayed" /></td>
									<td><a href=""><img src="images/up.png" class="displayed" /></a></td>
									<td><a href=""><img src="images/error.png" class="displayed" /></a></td>
									<td><a href="wordpot_config.html"><img src="images/file.png" class="displayed" /></a></td>
								</tr>
								<tr>
									<td>Conpot Honeypot</td>
									<td><?php if($conpot_pid !='') { echo '<img src="images/up.png"'; } else { echo '<img src="images/error.png"'; } ?> class="displayed" /></td>
									<td><a href=""><img src="images/up.png" class="displayed" /></a></td>
									<td><a href=""><img src="images/error.png" class="displayed" /></a></td>
									<td><a href="conpot_config.html"><img src="images/file.png" class="displayed" /></a></td>
								</tr>
								<tr>
									<td>HoneyD Honeypot</td>
									<td><?php if($honeyd_pid !='') { echo '<img src="images/up.png"'; } else { echo '<img src="images/error.png"'; } ?> class="displayed" /></td>
									<td><a href=""><img src="images/up.png" class="displayed" /></a></td>
									<td><a href=""><img src="images/error.png" class="displayed" /></a></td>
									<td><a href="honeyd_config.html"><img src="images/file.png" class="displayed" /></a></td>
								</tr>
								<tr>
									<td>PhoneyC</td>
									<td><?php if($phoneyc_pid !='') { echo '<img src="images/up.png"'; } else { echo '<img src="images/error.png"'; } ?> class="displayed" /></td>
									<td><a href=""><img src="images/up.png" class="displayed" /></a></td>
									<td><a href=""><img src="images/error.png" class="displayed" /></a></td>
									<td><a href="phoneyc_config.html"><img src="images/file.png" class="displayed" /></a></td>
								</tr>
								<tr>
									<td>Glastopf Honeypot</td>
									<td><?php if($glastopf_pid !='') { echo '<img src="images/up.png"'; } else { echo '<img src="images/error.png"'; } ?> class="displayed" /></td>
									<td><a href=""><img src="images/up.png" class="displayed" /></a></td>
									<td><a href=""><img src="images/error.png" class="displayed" /></a></td>
									<td><a href="glastopf_config.html"><img src="images/file.png" class="displayed" /></a></td>
								</tr>
								<tr>
									<td>Amun Honeypot</td>
									<td><?php if($amun_pid !='') { echo '<img src="images/up.png"'; } else { echo '<img src="images/error.png"'; } ?> class="displayed" /></td>
									<td><a href=""><img src="images/up.png" class="displayed" /></a></td>
									<td><a href=""><img src="images/error.png" class="displayed" /></a></td>
									<td><a href="amun_config.html"><img src="images/file.png" class="displayed" /></a></td>
								</tr>
							</tbody>
						</table>
					</font>
					</div>
					<br class="clear" />
   				</div>   			
	  		</div>
    			<br class="clear" />
  		   	
   		<div class="midBox1">
			<span><img src="images/undead1.jpg" width="303" height="420" alt="" /></span>
	     		<div class="midBox1Top">
		 		<h3>Who is Digitalized Warfare and The Dead Squad? We are just a group of guys who work tech jobs that still believe in free infosec for all..</h3>
		 		<p>Follow us on Twitter to the the most up to date news...<br /> Friend us on facebook to get current feeds..<br /> Get all the Source code on GITHUB.</p>
		 		<a href="https://twitter.com/digiwarfare"><img src="images/c2_i2.png" width="133" height="40" alt="" /></a>
		 		<a href="https://www.facebook.com/digi.wars.5"><img src="images/c2_i5.png" width="101" height="38" alt=""  /></a>	
				<a href="https://github.com/DigitalizedWarfare"><img src="images/github_logo.png" width="101" height="38" alt=""  /></a>	
	     		</div>
			<div class="midBox1Bottom">
		  		<h4>Want to follow us on the web?</h4>
		  		<ul>
		   			<li class="cat002">Our Main Site : <a href="http://www.digitalizedwarfare.com" >Digitalized Warfare</a></li>
		   			<li class="cat002">Our Squad Site : <a href="http://www.thedeadsquad.com" >The Dead Squad</a></li>
		   			<li class="cat002">Content Release Site : <a href="http://greycoatlabs.com/gcl-blog-2/" >GreyCoat Labs</a></li>
		   			<li class="cat002">Demo Videos : <a href="https://www.youtube.com/channel/UCugmfnH3Z_njlJyQ7Do5mCg" >Youtube Channel </a></li>
		  		</ul>
		 	</div>
		 	<br class="clear" />
	  	</div>
 	
		<div id="footerContainer">
    			<p><span>Copyright 2015 Digitalizedwarfare.com. All Rights Reserved</span></p>
		</div>
	</body>
</html>

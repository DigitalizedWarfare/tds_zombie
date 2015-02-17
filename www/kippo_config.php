<?php
if($_POST['config'] == 'kippo.cfg') {

	$filename='/opt/kippo/kippo.cfg';
	chmod ($filename, "0777");
	$myConfig=file_get_contents($filename);
	$confName=$_POST['config'];

} elseif($_POST['config'] == 'userdb.txt') {

	$filename='/opt/kippo/data/userdb.txt';
	chmod ($filename, "0777");
	$myConfig=file_get_contents($filename);
	$confName=$_POST['config'];

} else {

}

if(isset($_POST['builderDataWindow'])) {

        $a = $_POST['builderDataWindow'];
	
	if($_POST['confName'] == 'kippo.cfg') {
		$confName=$_POST['confName'];
	 	$myFile = '/opt/kippo/kippo.cfg';

	} elseif($_POST['confName'] == 'userdb.txt') {
		$confName=$_POST['confName'];
		$myFile = '/opt/kippo/data/userdb.txt';
	}
       	
	chmod ($myFile, "0777");
        $fh = fopen($myFile, 'w') or die("can't open file : " . $myFile);
        fwrite($fh, $a);
        fclose($fh);

	$myConfig=file_get_contents($myFile);

    } else {

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
					<li><a href="control_panel.html">Control Panel</a></li>
					<li><a href="kippo_config.html" class="topNavAct">Kippo</a></li>
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
						<form method="POST" action="" name="builderData" id="buildData">
						<input type="hidden" name="confName" id="" value="<?php echo $confName; ?>"/>
	  					<h4>Config Building Window</h4>
	  					<div class="builderFormR">
	   						<p><textarea id="builderDataWindow" name="builderDataWindow" class="buildertextarea" rows="2" cols="3"><?php echo $myConfig; ?></textarea></p>
       					 		<input name="submit" value="" type="submit" class="builderSubmit"/>
	  					</div>
						</form>
	  					<br class="clear" />
	  				</div>
					<div class="builderFormMenu">
					 	<p>Welcome to the Kippo SSH Honeypot confitg builder. Here are a few things that you want to edit
						Some Honeypots have more then one config. You will need to restart the service for your changes to take
						effect.
						</p>
						<br />
						<form method="POST" action="" name="loadDataFile" id="loadDataFile">
						<select name="config">
							<option value="kippo.cfg">&nbsp; Kippo Main Config &nbsp;</option>
							<option value="userdb.txt">&nbsp; Kippo User Database &nbsp;</option>
						</select>
						<input name="submit" value="" type="submit" class="builderSubmit"/>
						</form>
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

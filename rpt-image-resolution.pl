#!/usr/local/bin/perl
use warnings;
use strict; 
use feature qw(say);

use Config::Simple;
use FindBin;
use lib "$FindBin::Bin/./imu-1.0.03/";

use IMu;
use IMu::Session;
use IMu::Module;
use Data::Dumper;


sub export {	
	my $paramsref = shift;
	my %params = %{$paramsref};
	
	say "Offset: " . $params{"offset"};
	
	
	my $cfg = new Config::Simple('imu.ini');

	# accessing values:
	my $user = $cfg->param('user');
	my $pass = $cfg->param('pass');
	my $port = $cfg->param('port');
	my $host = $cfg->param('host');


	my $session = IMu::Session->new();
	
	$session->setHost($host);
	$session->setPort($port);
	$session->connect($user,$pass);
	$session->login();

	# connect to the locations module
	my $locs = IMu::Module->new('emultimedia', $session);

	my $terms = ['MulMimeType', "image"];

	$locs->findTerms($terms);

	my $columns = ['ChaImageWidth,irn,ChaImageHeight,DetResourceType,MulIdentifier'];
	my $results = $locs->fetch('start',$params{"offset"},$params{"count"},$columns);
	my $rows = $results->{rows};
	
	if($results->{count} < $params{"count"}) {
		say length($rows) . " length(rows) --- Count" . $params{"count"};
		$params{"allDone"} = 1;
		say "ALL DONE!";
	} else {
		$params{"offset"} = $params{"offset"} + $params{"count"};
	}

	# disconnect from server
	$session->disconnect();
	
	foreach my $row (@$rows) {
		# print Dumper ($row);
		writeToFile( $row );
	}
	return %params;
}

sub writeToFile {
	my $row = shift;
	if(not defined($row->{ChaImageHeight}) or not defined($row->{ChaImageWidth}) ) {
		#say "Height/Width is undefined";
	}
	elsif($row->{ChaImageHeight} < 800 and  $row->{ChaImageWidth} < 800) {
		# say "Found one that is less than web-publishable " . $row->{irn};
		print LOG_FILE  $row->{irn} . "," . $row->{ChaImageHeight} . "," . $row->{ChaImageWidth} . ",\"" . $row->{DetResourceType} . "\",\"" . $row->{MulIdentifier} . "\"\n";
	}
}
# end sub

# begin main

# LOG_FILE
my $file = "../rpt-image-resolution.csv";
unless(open LOG_FILE, '>'.$file) {
	die "\nUnable to create LOG_FILE\n";
}
#headers 
print LOG_FILE "irn,height,width,resouce type,filename\n";

# fetch hash
my %return = ( 
	'allDone' => 0,
	'offset' => 0,
	'count' => 1000,
	);
		
while(not $return{"allDone"}) {
	%return = export(\%return);
}

exit;


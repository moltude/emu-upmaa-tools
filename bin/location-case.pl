#!/usr/local/bin/perl
use warnings;
use strict; 
use feature qw(say);

use Config::Simple;
use FindBin;
use lib "$FindBin::Bin/../imu-1.0.03/";

use IMu;
use IMu::Session;
use IMu::Module;
use Data::Dumper;

my $cfg = new Config::Simple('../imu.ini');

# get conf.
my $user = $cfg->param('user');
my $pass = $cfg->param('pass');
my $port = $cfg->param('port');
my $host = $cfg->param('host');


# connect and run
my $session = IMu::Session->new();

$session->setHost($host);
$session->setPort($port);
$session->connect($user,$pass);
$session->login();

# connect to the locations module
my $locs = IMu::Module->new('elocations', $session);

# my $terms = ['LocLocationType', 'Location'];
my $terms = ['LocLevel1', 'B42'];

$locs->findTerms($terms);

my $columns = ['LocLevel1','LocLevel2','LocLevel3','LocLevel4','LocLevel5','LocLevel6','LocLevel7','LocLevel8','irn', 'SummaryData'];
my $results = $locs->fetch('start',0,-1,$columns);
my $rows = $results->{rows};

# disconnect from server
$session->disconnect();

foreach my $row (@$rows) {
	# Check to see if the record needs to updated (i.e. fixed). 
	if($row->{SummaryData} ne uc($row->{SummaryData})) {
		# pass the record to the uc sub 
		say('Before  ' . $row->{SummaryData});
		$row = upperCase($row);
		say('After   ' . uc($row->{SummaryData}));
		# pass it back to emu as an update
		updateRecord($row);
		# log it
	}
}

# Changes the lower case values to upper case
sub upperCase {
	my $row = $_[0];
	for (my $count = 1; $count < 9; $count++) {
		my $level = "LocLevel" . $count;
		if(defined($row->{$level})) {
			if($row->{$level} ne uc($row->{$level})) {
				$row->{$level} = uc($row->{$level});
			}
		} else {
			delete $row->{$level};
		}
	}
	return $row;
}

# Updates the record in Emu
sub updateRecord {
	my $location = $_[0];
	my $irn = $location->{irn};
	
	delete $location->{irn};
	delete $location->{SummaryData};
	delete $location->{rownum};
	
	# print (Dumper($location));
	
	my $session = IMu::Session->new();

	# TO DO CONNECT
	$session->setHost($host);
	$session->setPort($port);
	$session->connect($user,$pass);
	$session->login();


	# connect to the locations module
	my $locs = IMu::Module->new('elocations', $session);
	$locs->findKey($irn);
	$locs->fetch("start",0,1);
	$locs->update("start",0,1,$location);
	
	$session->disconnect();
}
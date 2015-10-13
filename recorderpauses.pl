#!/usr/local/bin/perl

# Anne S. Warlaumont
# Last update: February 14, 2013

# How to run this script: perl recorderpauses.pl /Users/awarlau/LENAInteraction/MemphisLENARecordings/itsfiles/e20070225_191245_003110.its  /Users/awarlau/LENAInteraction/MemphisLENARecordings/postitsfiles/PauseTimes_e20070225_191245_003110.txt

# Take the following command line arguments:
# 1: The (path and) filename of the its file. E.g. "e20070225_191245_003110.its"
# 2: The (path and) filename of the output file. E.g. "e20070225_191245_003110_PauseTimes.txt"

use strict; use warnings;

print "test recorderpauses input 1: "; print $ARGV[0]; print "\n";
print "test recorderpauses input 2: "; print $ARGV[1]; print "\n";


open INPUTFILE, $ARGV[0] or die "Could not open its file\n";
open OUTPUTFILE, ">", $ARGV[1] or die "Could not open recorderpauses output file\n";

while (my $line = <INPUTFILE>){

	chomp($line);
	
	last if ($line=~ m/All about the Bars/);
	
	if ($line=~ m/<Recording num/){

		my $endTime = $line;
		$endTime =~ s/.*endTime="PT//g;
		$endTime =~ s/S".*//g;
		
		my $startTime = $line;
		$startTime =~ s/.*startTime="PT//g;
		$startTime =~ s/S".*//g;

		my $startclocktime = $line;
		$startclocktime =~ s/.*startClockTime="//g;
		$startclocktime =~ s/Z".*//g;
		
		my $endclocktime = $line;
		$endclocktime =~ s/.*endClockTime="//g;
		$endclocktime =~ s/Z".*//g;
		
		print OUTPUTFILE "$startTime\t$endTime\t$startclocktime\t$endclocktime\n";
		
	}
	
}

close(INPUTFILE);

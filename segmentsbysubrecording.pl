#!/usr/local/bin/perl

# Anne S. Warlaumont
# Last update: February 14, 2013

# Example of how to run this script: perl segmentsbysubrecording.pl /Users/awarlau/LENAInteraction/MemphisLENARecordings/postitsfiles/e20080828_165836_003407_PauseTimes.txt /Users/awarlau/LENAInteraction/MemphisLENARecordings/postitsfiles/e20080828_165836_003407ANStartAndEndTimes_IncludeOverlap.txt 

# Take the following command line arguments:
# 1: The (path and) filename of the pause times file. E.g. "e20080304_150244_003407_PauseTimes.txt"
# 2: The (path and) filename of the segment times input file. E.g. "e20080304_150244_003407ANStartAndEndTimes_IncludeOverlap.txt"
# 3: The column of the segment times input file that contains the start time. For single speaker files, this will be the first column. For combined speaker files, this will be the second.

use strict; use warnings;

print "test segmentsbysubrecording input 1: "; print $ARGV[0]; print "\n";
print "test segmentsbysubrecording input 2: "; print $ARGV[1]; print "\n";
print "Column containing the start time: "; print $ARGV[2]; print "\n";

my $stcol = $ARGV[2];

open PAUSEINPUTFILE, $ARGV[0] or die "Could not open the pause times input file\n";
my @pauses = <PAUSEINPUTFILE>;
close(PAUSEINPUTFILE);

open SEGINPUTFILE, $ARGV[1] or die "Could not open the segment times input file\n";
my $segoutfilebase = $ARGV[1];
$segoutfilebase =~ s/\.txt//g;
my $subreccount = 1;
open SEGOUTFILE, ">", $segoutfilebase . $subreccount . ".txt" or die "Could not open output file\n";
while (my $line = <SEGINPUTFILE>){
	#my $line = <SEGINPUTFILE>;
	my @seginfo = split(m[(?:\s+|^I|\n)+],$line);
	my $pauseline = $pauses[$subreccount-1];
	my @pauseinfo = split(m[(?:\s+|^I|\n)+],$pauseline);
	if ($seginfo[$stcol-1]>$pauseinfo[1]){
		$subreccount++;
		close(SEGOUTFILE);
		open  SEGOUTFILE, ">", $segoutfilebase . $subreccount . ".txt" or die "Could not open output file\n";
	}
	print SEGOUTFILE $line;
}
close(SEGOUTFILE);
close(SEGINPUTFILE);
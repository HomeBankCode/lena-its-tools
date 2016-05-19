#!/usr/local/bin/perl

# Anne S. Warlaumont
# Last update: May 18, 2016

# This tool identifies segments within subrecordings of a LENA recording. 
# A new file containing the start and end times for each segment will be created for each subrecording of the entire recording.
# e.g., e20131210_144819_009143CHN_AN_Segments1.txt; e20131210_144819_009143CHN_AN_Segments2.txt; e20131210_144819_009143CHN_AN_Segments3.txt

# Take the following command line arguments:
# 1: The (path and) filename of the pause times file. E.g. "e20131210_144819_009143_PauseTimes.txt"
# 2: The (path and) filename of the segment times input file. E.g. "e20131210_144819_009143CHN_AN_Segments.txt"
# e.g. perl segmentsbysubrecording.pl ~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145\_PauseTimes.txt ~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145CHN_AN_Segments.txt 

# For single speaker files, the first column is the start time, but for combined speaker files, the second column is the the start time.

use strict; use warnings;H

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
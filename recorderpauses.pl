# This tool allows you to find out the exact time(s) a recorder was paused. 

# Take the following command line arguments:
# 1: The (path and) filename of the its file. E.g. "e20070225_191245_003110.its"
# 2: The (path and) filename of the output file. E.g. "e20070225_191245_003110_PauseTimes.txt"

# Instructions:
# 1. Open up a unix shell (e.g. the Terminal application under Utilities on Mac or Cygwin on Windows)
# 2. Navigate to the directory where this file is located (e.g. "~/Desktop/lena-its-tools/")
# 3. Run recorderpauses.pl with the path and file name of the its file as the first argument and the path and name of the desired txt output file as the 2nd argument
# (e.g. "perl recorderpauses.pl /Users/awarlau/LENAInteraction/MemphisLENARecordings/itsfiles/e20070225_191245_003110.its  /Users/awarlau/LENAInteraction/MemphisLENARecordings/postitsfiles/PauseTimes_e20070225_191245_003110.txt")

# Written by Anne S. Warlaumont

use strict; use warnings;

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

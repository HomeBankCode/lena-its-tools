# This tool identifies segments within subrecordings of a LENA recording. 
# A new file containing the start and end times for each segment will be created for each subrecording of the entire recording.

# Take the following command line arguments:
# 1: The (path and) filename of the pause times file. E.g. "e20080304_150244_003407_PauseTimes.txt"
# 2: The (path and) filename of the segment times input file. E.g. "e20080304_150244_003407ANStartAndEndTimes.txt" or "e20080304_150244_003407_Segments.csv"
# 3: The column of the segment times input file that contains the start time. For single speaker files, this will be the first column. For combined speaker files, including those created by segments.pl, this will be the second column.
# 4: An indication of whether or not there is a header line in the segment times input file. Set to 0 if there's no header. Set to 1 if there is a header.
# e.g. perl segmentsbysubrecording /PathToPauseTimesFile/e20131126_15502_009145_PauseTimes.txt /PathToOutputOfSegmentsDotPl/e20131126_15502_009145_Segments.txt 2 1
# e.g. perl segmentsbysubrecording.pl ~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145\_PauseTimes.txt ~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145CHN_AN_Segments.txt 1 0
# Note some differences between these examples and the screenshots in the documentation

# Written by Anne S. Warlaumont

# For single speaker files, the first column is the start time, but for combined speaker files, the second column is the the start time.

use strict; use warnings;

use strict; use warnings;

my $stcol = $ARGV[2];
my $isHeader = $ARGV[3];

open PAUSEINPUTFILE, $ARGV[0] or die "Could not open the pause times input file\n";
my @pauses = <PAUSEINPUTFILE>;
close(PAUSEINPUTFILE);

open SEGINPUTFILE, $ARGV[1] or die "Could not open the segment times input file\n";
my $segoutfilebase = $ARGV[1];
$segoutfilebase =~ s/\.txt//g;
$segoutfilebase =~ s/\.csv//g;
my $subreccount = 1;
open SEGOUTFILE, ">", $segoutfilebase . $subreccount . ".txt" or die "Could not open output file\n";
my $headline;
if ($isHeader) {
	$headline = <SEGINPUTFILE>;
	print SEGOUTFILE $headline;
}
while (my $line = <SEGINPUTFILE>){
	my @seginfo = split(m[\s|,|\n],$line); # TO do: Add comma separation to this line, and also figure out what the ^I was for when processing one of the old formatted segments files.
	my $pauseline = $pauses[$subreccount-1];
	my @pauseinfo = split(m[\s|,|\n],$pauseline);
	if ($seginfo[$stcol-1]>=$pauseinfo[1]){
		$subreccount++;
		close(SEGOUTFILE);
		open  SEGOUTFILE, ">", $segoutfilebase . $subreccount . ".txt" or die "Could not open output file\n";
		if ($isHeader) {
			print SEGOUTFILE $headline;
		}
	}
	print SEGOUTFILE $line;
}
close(SEGOUTFILE);
close(SEGINPUTFILE);
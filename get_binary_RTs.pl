#!/usr/local/bin/perl

# Anne S. Warlaumont

# When a sequence of 1 or more child (or adult) segments is produced with no more than 1 
# second intervening between the segments, find out if an adult (or child) segment 
# followed within 1 second or less.

# Take 4 command line arguments: 
# 1. The name of the combined AN and CHN input file
# 2. The name of the child response probability output file
# 3. The name of the adult response probability output file
# 4. Whether turns with overlap in between should be excluded or not (if yes, 'true'; if not, 'false')
# 5. The CHN Utt duration cutoff above which a child vocalization is said to consider speech-related material

# Instructions:
# 1. Open up a unix shell (e.g. the Terminal application under Utilities on Mac or Cygwin on Windows)
# 2. Navigate to the directory where this file is located (e.g. "~/Desktop/lena-its-tools/")
# 3. Run recorderpauses.pl with the path and file name of the combined AN and CHN input file as the first argument; the path and name file of the child response probability as the 2nd argument;
#    the path and file name of the adult response probability output file as the 3rd argument; whether turns with overlap in between should be excluded as the 4th argument;
#    and the CHN Utt duration cutoff above which a child vocalization is said to consider speech-related material as the 5th argument. 
#   (e.g. "perl recorderpauses.pl ~Desktop/Gina/Participants/WW04/e20131126_155022_009145CHN_AN_Segments.txt  ~Desktop/Gina/Participants/WW04/e20131126_155022_009145ChildResponseProb.txt ~Desktop/Gina/Participants/WW04/e20131126_155022_009145AdultResponseProb.txt true 1")


use strict; use warnings;

my $inputfile = $ARGV[0];
my $childOutputfile = $ARGV[1];
my $adultOutputfile = $ARGV[2];
my $excludeTurnsWithOverlapInBetween = $ARGV[3];
my $chnUttCutoff = $ARGV[4];

open INPUTFILE, "<", $inputfile or die "Could not open $inputfile \n";
open CHILDOUTPUTFILE, ">", $childOutputfile or die "Could not open $childOutputfile \n";
open ADULTOUTPUTFILE, ">", $adultOutputfile or die "Could not open $adultOutputfile \n";

print CHILDOUTPUTFILE "chnUttDur\tchnCryVfxDur\tchnRT\tpreviousANRT\tpreviousANRTtoUtt\tpreviousANRTtoCryVfx\n";
print ADULTOUTPUTFILE "chnUttDur\tchnCryVfxDur\tanRT\n";

my $anEnd = "NA";
my $chnEnd = "NA";
my $chnUttDur = "NA";
my $chnCryVfxDur = "NA";
my $chnBegin;
my $anBegin;
my $olnBegin;
my $childResponseTime = "NA";
my $adultResponseTime = "NA";
my $adultResponseTimeToUtt = "NA";
my $adultResponseTimeToCryVfx = "NA";

while (my $line = <INPUTFILE>){

	chomp($line);

	my @columns = split(/\s+/,$line); # put column values for $line in an array by splitting on whitespace
	
	if ($columns[0] eq "CHN"){
	
		$chnBegin = $columns[1];
		
		if (($chnEnd ne "NA") && (($chnBegin - $chnEnd) > 1)) {
			$adultResponseTime = 1.1;
			if ($chnUttDur > $chnUttCutoff) {
				$adultResponseTimeToUtt = $adultResponseTime;
			}
			if ($chnCryVfxDur > 0) {
				$adultResponseTimeToCryVfx = $adultResponseTime;
			}
			print ADULTOUTPUTFILE "$chnUttDur\t$chnCryVfxDur\t$adultResponseTime\n";
		}
		
		$chnEnd = $columns[2];
		$chnUttDur = $columns[3];
		$chnCryVfxDur = $columns[4];
		
		if ($anEnd ne "NA"){
			$childResponseTime = $chnBegin - $anEnd;
			if ($childResponseTime > 1){
				$childResponseTime = 1.1;
			}
			else{
				$childResponseTime = 0;
			}
		}
		else{
			$childResponseTime = "NA";
		}
		print CHILDOUTPUTFILE "$chnUttDur\t$chnCryVfxDur\t$childResponseTime\t$adultResponseTime\t$adultResponseTimeToUtt\t$adultResponseTimeToCryVfx\n";
		
		$anEnd = "NA";
		
	}

	if ($columns[0] eq "AN"){

		$anBegin = $columns[1];
		
		if (($anEnd ne "NA") && (($anBegin - $anEnd) > 1)) {
			$childResponseTime = 1.1;
			print CHILDOUTPUTFILE "$chnUttDur\t$chnCryVfxDur\t$childResponseTime\t$adultResponseTime\t$adultResponseTimeToUtt\t$adultResponseTimeToCryVfx\n";
		}
		
		$anEnd = $columns[2];

		if ($chnEnd ne "NA"){
			$adultResponseTime = $anBegin - $chnEnd;
			if ($adultResponseTime > 1){
				$adultResponseTime = 1.1;
			}
			else{
				$adultResponseTime = 0;
			}
			if ($chnUttDur > $chnUttCutoff) {
				$adultResponseTimeToUtt = $adultResponseTime;
			}
			if ($chnCryVfxDur > 0) {
				$adultResponseTimeToCryVfx = $adultResponseTime;
			}
			print ADULTOUTPUTFILE "$chnUttDur\t$chnCryVfxDur\t$adultResponseTime\n";
		}
		
		$chnEnd = "NA";
		$chnUttDur = "NA";
		$chnCryVfxDur = "NA";

	}
	
	if (($excludeTurnsWithOverlapInBetween eq 'true') && ($columns[0] eq "OLN")){
		
		$olnBegin = $columns[1];
		
		if ($anEnd ne "NA"){
			if (($olnBegin - $anEnd) > 1){
				$childResponseTime = 1.1;
				$chnUttDur = "NA";
				$chnCryVfxDur = "NA";
				print CHILDOUTPUTFILE "$chnUttDur\t$chnCryVfxDur\t$childResponseTime\t$adultResponseTime\t$adultResponseTimeToUtt\t$adultResponseTimeToCryVfx\n";
			}
		}
		
		if ($chnEnd ne "NA"){
			if (($olnBegin - $chnEnd) > 1){
				$adultResponseTime = 1.1;
				if ($chnUttDur > $chnUttCutoff) {
					$adultResponseTimeToUtt = $adultResponseTime;
				}
				if ($chnCryVfxDur > 0) {
					$adultResponseTimeToCryVfx = $adultResponseTime;
				}
				print ADULTOUTPUTFILE "$chnUttDur\t$chnCryVfxDur\t$adultResponseTime\n";
			}
		}
		
		$anEnd = "NA";
		$chnEnd = "NA";
		$chnUttDur = "NA";
		$chnCryVfxDur = "NA";
		
	}
	
}


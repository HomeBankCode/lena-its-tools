#!/usr/local/bin/perl

# Anne S. Warlaumont

# When a sequence of one or more child (or adult) segments is produced with no more than t 
# seconds intervening between the segments, find out if an adult (or child) segment 
# followed within t seconds or less. We do not ask if non-speech-related (reflexive & vegetative)
# child vocalizations receive adult responses. If a child speech-related vocalization is followed
# within 1 s by a reflexive or vegetative child vocalization, we say adult response is NA (same if
# a speaker's segment is followed within 1 s by the same type of speaker segment).

# This is a more intuitive adaptation of get_binary_RTs.

# Take 3-4 command line arguments: 
# 1. The name of the segments input file (created using segments.pl)
# 2. The name of the adult responses to child output file
# 3. The name of the child responses to adult output file
# 4. The value of t in seconds (e.g., set to 1 to indicate that following event must have a start time of no more than 1 s after the end time of the preceding eventin order to be counted as a response)

# Instructions:
# 1. Open up a Unix shell (e.g. the Terminal application under Utilities on Mac or Cygwin on Windows)
# 2. Navigate to the directory where this file is located (e.g. "~/Desktop/lena-its-tools/")
# 3. Run recorderpauses.pl with:
#    - path and file name of the combined AN and CHN input file as the first argument;
#    - the path and name file of the child response probability as the 2nd argument;
#    - the path and file name of the adult response probability output file as the 3rd argument;
#    - and the response time threshold in seconds as the 4th argument.
#    For example: "perl responses.pl ~Desktop/Gina/Participants/WW04/e20131126_155022_009145_Segments.txt ~Desktop/Gina/Participants/WW04/e20131126_155022_009145_AdultResponsesToChild.txt ~Desktop/Gina/Participants/WW04/e20131126_155022_009145_ChildResponsesToAdult.txt 1"


use strict; use warnings;

my $inputfile = $ARGV[0];
my $adultResponseToChildOutputfile = $ARGV[1];
my $childResponseToAdultOutputfile = $ARGV[2];
my $response_t= $ARGV[3];

open INPUTFILE, "<", $inputfile or die "Could not open $inputfile \n";
open ADULT_RESP_2_CHILD_OUTFILE, ">", $adultResponseToChildOutputfile or die "Could not open $adultResponseToChildOutputfile \n";
open CHILD_RESP_2_ADULT_OUTFILE, ">", $childResponseToAdultOutputfile or die "Could not open $childResponseToAdultOutputfile \n";

print ADULT_RESP_2_CHILD_OUTFILE "chnStartTime\tchnEndTime\tchildReceivedAdultResponse\n";
print CHILD_RESP_2_ADULT_OUTFILE "anStartTime\tanEndTime\tadultReceivedChildResponse\n";

my $prevChildBegin;
my $prevChildEnd;
my $prevChildGotResponse;
my $prevAdultBegin;
my $prevAdultEnd;
my $prevAdultGotResponse;
my $currSpeaker;
my $currBegin;
my $currEnd;

while (my $line = <INPUTFILE>){

	chomp($line);

	my @columns = split(/,/,$line); # put column values for $line in an array by splitting on whitespace
	
	if ($columns[0] eq "CHNSP"){
		$currSpeaker = "Child";
	} elsif ($columns[0] eq "CHNNSP"){
		$currSpeaker = "ChildCry";
	} elsif (($columns[0] eq "MAN") or ($columns[0] eq "FAN")){
		$currSpeaker = "Adult";
	} else {
		$currSpeaker = "Other";
	}
	
	$currBegin = $columns[1];
	$currEnd = $columns[2];
	
	if (defined($prevChildBegin)){
		if (($currBegin-$prevChildEnd) <= $response_t){
			if ($currSpeaker eq "Adult"){
				$prevChildGotResponse = "yes";
			} elsif (($currSpeaker eq "Child") or ($currSpeaker eq "ChildCry")){
				$prevChildGotResponse = "NA";
			}
		} elsif (($currBegin-$prevChildEnd) > $response_t){
			$prevChildGotResponse = "no";
		}
	}
	
	if (defined($prevChildGotResponse)){
		print ADULT_RESP_2_CHILD_OUTFILE "$prevChildBegin\t$prevChildEnd\t$prevChildGotResponse\n";
		undef $prevChildBegin;
		undef $prevChildEnd;
		undef $prevChildGotResponse;
	}
	
	if (defined($prevAdultBegin)){
		if (($currBegin-$prevAdultEnd) <= $response_t){
			if ($currSpeaker eq "Child"){
				$prevAdultGotResponse = "yes";
			} elsif ($currSpeaker eq "Adult"){
				$prevAdultGotResponse = "NA";
			}
		} elsif (($currBegin-$prevAdultEnd) > $response_t){
			$prevAdultGotResponse = "no";
		}
	}
	
	if (defined($prevAdultGotResponse)){
		print CHILD_RESP_2_ADULT_OUTFILE "$prevAdultBegin\t$prevAdultEnd\t$prevAdultGotResponse\n";
		undef $prevAdultBegin;
		undef $prevAdultEnd;
		undef $prevAdultGotResponse;
	}
	
	if ($currSpeaker eq "Child"){
		$prevChildBegin = $currBegin;
		$prevChildEnd = $currEnd;
	} elsif ($currSpeaker eq "Adult"){
		$prevAdultBegin = $currBegin;
		$prevAdultEnd = $currEnd;
	}
	
}

close ADULT_RESP_2_CHILD_OUTFILE;
close CHILD_RESP_2_ADULT_OUTFILE;


#!/usr/local/bin/perl

# Anne S. Warlaumont

# This tool allows you to create new files with: 
# 1.) Child vocalization start and end times, as well as the duration of speech related (utt) and not speech related (cry);
# 2.) Adult vocalization start and end times; and 
# 3.) Child vocalization start and end times, as well as the duration of speech related (utt) and not speech related (cry) AND Adult vocalization start and end times

# Takes 6 command line arguments:
# 1: The (path and) file name of the input file. (e.g. "e20070225_191245_003110.its")
# 2: The (path and) file name of the child output file. (e.g. "e20070225_191245_003110_CHNStartEndUttCryTimes.txt")
# 3: The (path and) file name of the adult output file. (e.g. "e20070225_191245_003110_ANStartAndEndTimes.txt")
# 4: The (path and) file name of the combined child + adult output file. (e.g. "e20070225_191245_003110_CHN_AN_Segments.txt")
# 5: The mode for dealing with overlap: "IgnoreOverlap", "TreatOverlapAsAdult", "TreatOverlapAsChild", "DeleteOverlap", "IncludeOverlapExcludeIntervening", or "IncludeOverlapIgnoreIntervening" (recommended value is "IgnoreOverlap")
# 6: The maximum length the recording should be truncated at (in seconds). For a 16 hour recording, use 57600.

# Instructions:
# 1.) Open up a unix shell (e.g., the Terminal application under Utilities on Mac or Cygwin on Windows)
# 2.) Navigate to the directory where "readits_start_end_content.pl" is located (e.g. ~/Desktop/lena-its-tools/)
# 3.) Run readits_start_end_content.pl with the (path and) file name as the first argument, the (path and) file name of the child output file as the second argument;
#	  the (path and) file name of the adult output file as the third argument; the (path and) file name of the combine child and adult output file as the third argument;
#     the mode for dealing with the overlap as the fifth argument, and the maximum length the recording should be truncated at as the sixth argument;
#	  (e.g. perl readits_start_end_content. pl e20070225_191245_003110.its e20070225_191245_003110_CHNStartEndUttCryTimes.txt e20070225_191245_003110_ANStartAndEndTimes.txt e20070225_191245_003110_CHN_AN_Segments.txt "IgnoreOverlap" 57600)

use strict;
use warnings;

my $maxsecs = $ARGV[5];
print $ARGV[1]; print "\n";


open INPUTFILE, $ARGV[0] or die "Could not open input file " . $ARGV[0] . "\n";
open CHNOUTPUTFILE, ">", $ARGV[1] or die "Could not open child output file" . $ARGV[1] . "\n";
open ANOUTPUTFILE, ">", $ARGV[2] or die "Could not open adult output file\n";
open COMBINED_OUTPUTFILE, ">", $ARGV[3] or die "Could not open combined output file\n";
my $overlapMode = $ARGV[4];
my $totalOverlapTime = 0;

while (my $line = <INPUTFILE>){

    chomp($line);	
    
	if ($line=~ m/Segment spkr="OLN"/){
		
		my $overlapStartTime = $line;
        my $overlapEndTime = $line;
        $overlapStartTime =~ s/.*startTime="PT//g;
        $overlapStartTime =~ s/S" endTime=.*//g;
        if ($overlapStartTime >=$maxsecs){
        	last;
        }
        $overlapEndTime =~ s/.*endTime="PT//g;
        $overlapEndTime =~ s/S".*//g;
        if ($overlapEndTime >= $maxsecs){
        	$overlapEndTime = $maxsecs;
    	}
    	$totalOverlapTime = $totalOverlapTime + $overlapEndTime - $overlapStartTime;
        
        if ($overlapMode=~ m/IncludeOverlap/){
			print COMBINED_OUTPUTFILE "OLN\t$overlapStartTime\t$overlapEndTime\n";
        }
        
        if ($overlapEndTime == $maxsecs){
        	last;
        }
        
	}
	
    if (($line=~ m/Segment spkr="CHN"/) || (($line=~ m/Segment spkr="OLN"/) && ($overlapMode eq "TreatOverlapAsChild"))) { # detect whether the line is for a CHN segment
        my $startTime = $line;
        my $endTime = $line;
        my $childUttLen = $line;
        my $childCryVfxLen = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        if ($line=~m/Segment spkr="CHN"/){
			$childUttLen =~ s/.*childUttLen="PT?//g;
			$childUttLen =~ s/S".*//g;    
			$childCryVfxLen =~ s/.*childCryVfxLen="PT?//g;
			$childCryVfxLen =~ s/S".*//g;
		}
        elsif ($line=~ m/Segment spkr="OLN"/){
        	$childUttLen = "NA";
        	$childCryVfxLen = "NA";
        }
        my $realEndTime = $endTime;
        if ($overlapMode eq "DeleteOverlap"){
        	$startTime = $startTime - $totalOverlapTime;
        	$endTime = $endTime - $totalOverlapTime; 
        }
        print CHNOUTPUTFILE "$startTime\t$endTime\t$childUttLen\t$childCryVfxLen\n";
		print COMBINED_OUTPUTFILE "CHN\t$startTime\t$endTime\t$childUttLen\t$childCryVfxLen\n";
		
		if ($realEndTime == $maxsecs){
        	last;
        }
		
    }

    if (($line=~ m/Segment spkr="FAN"/)||($line=~ m/Segment spkr="MAN"/)|| (($line=~ m/Segment spkr="OLN"/) && ($overlapMode eq "TreatOverlapAsAdult"))){
        my $startTime = $line;
        my $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
    	my $realEndTime = $endTime;
        if ($overlapMode eq "DeleteOverlap"){
        	$startTime = $startTime - $totalOverlapTime;
        	$endTime = $endTime - $totalOverlapTime;
        }
		print ANOUTPUTFILE "$startTime\t$endTime\n";
		print COMBINED_OUTPUTFILE "AN\t$startTime\t$endTime\n";
		
		if ($realEndTime == $maxsecs){
        	last;
        }
        
    }
    
}

close(INPUTFILE);
close(CHNOUTPUTFILE);
close(ANOUTPUTFILE);
close(COMBINED_OUTPUTFILE);

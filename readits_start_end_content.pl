#!/usr/local/bin/perl

# Anne S. Warlaumont

# take 5 command line arguments:
# 1: The (path and) file name of the input file. E.g. "e20070225_191245_003110.its"
# 2: The (path and) file name of the child output file. E.g. "CHNStartEndUttCryTimese20070225_191245_003110.txt"
# 3: The (path and) file name of the adult output file. E.g. "ANStartAndEndTimese20070225_191245_003110.txt"
# 4: The (path and) file name of the combined child + adult output file. E.g. "CHN_AN_Segments_e20070225_191245_003110.txt"

# 5: The mode for dealing with overlap: "IgnoreOverlap", "TreatOverlapAsAdult", "TreatOverlapAsChild", "DeleteOverlap", "IncludeOverlapExcludeIntervening", or "IncludeOverlapIgnoreIntervening" (recommended value is "IgnoreOverlap")

use strict;
use warnings;

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
        if ($overlapStartTime >=43200){
        	last;
        }
        $overlapEndTime =~ s/.*endTime="PT//g;
        $overlapEndTime =~ s/S".*//g;
        if ($overlapEndTime >= 43200){
        	$overlapEndTime = 43200;
    	}
    	$totalOverlapTime = $totalOverlapTime + $overlapEndTime - $overlapStartTime;
        
        if ($overlapMode=~ m/IncludeOverlap/){
			print COMBINED_OUTPUTFILE "OLN\t$overlapStartTime\t$overlapEndTime\n";
        }
        
        if ($overlapEndTime == 43200){
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
        if ($startTime >=43200){
        	last;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= 43200){
        	$endTime = 43200;
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
		
		if ($realEndTime == 43200){
        	last;
        }
		
    }

    if (($line=~ m/Segment spkr="FAN"/)||($line=~ m/Segment spkr="MAN"/)|| (($line=~ m/Segment spkr="OLN"/) && ($overlapMode eq "TreatOverlapAsAdult"))){
        my $startTime = $line;
        my $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=43200){
        	last;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= 43200){
        	$endTime = 43200;
    	}
    	my $realEndTime = $endTime;
        if ($overlapMode eq "DeleteOverlap"){
        	$startTime = $startTime - $totalOverlapTime;
        	$endTime = $endTime - $totalOverlapTime;
        }
		print ANOUTPUTFILE "$startTime\t$endTime\n";
		print COMBINED_OUTPUTFILE "AN\t$startTime\t$endTime\n";
		
		if ($realEndTime == 43200){
        	last;
        }
        
    }
    
}

close(INPUTFILE);
close(CHNOUTPUTFILE);
close(ANOUTPUTFILE);
close(COMBINED_OUTPUTFILE);

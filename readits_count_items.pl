#!/usr/local/bin/perl

# Anne S. Warlaumont

# This tool allows you to create a .txt output file with the total duration and total count of various events.

# Takes 4 command line arguments:
# 1: The (path and) file name of the input .its file. (e.g., ~/Desktop/Participants/WW04/e20131126_155022_009145.its)
# 2: The (path and) file name of the output file. (e.g., ~/Desktop/Participants/WW04/CountItemsOutput.txt)
# 3: The maximum length the recording should be truncated at (in seconds), or the end time when to stop counting (for 24 hour recording, set to 86400; for 16 hour recording, set to 57600s)
# 4: The start time when to start counting (to start at the beginning, set to 0)

# Instructions:
# 1.) Open up a unix shell (e.g. the Terminal application under Utilities on Mac or Cygwin on Windows)
# 2.) Navigate to the directory where readits_count_items.pl is located (e.g. ~/Desktop/lena-its-tools/)
# 3.) Run readits_count_items.pl with the (path and) file name of the input file as the first argument, the (path and) file name of the output file as the second argument,
# 	  the maximum length the recording should be truncated at as the third argument, and the start time of when to start counting as the fourth argument.
# 	  (e.g. perl readits_count_items.pl ~/Desktop/Participants/WW04/e20131126_155022_009145.its ~/Desktop/Participants/WW04/CountItemsOutput.txt 57600 0)

use strict;
use warnings;

my $maxsecs = $ARGV[2];
my $minsecs = $ARGV[3];
print $ARGV[0] . "\n";

open INPUTFILE, $ARGV[0] or die "Could not open input file\n";
open OUTPUTFILE, ">", $ARGV[1] or die "Could not open child output file" . $ARGV[1] . "\n";
my $totalMANTime = 0;
my $totalMAFTime = 0;
my $totalFANTime = 0;
my $totalFAFTime = 0;
my $totalCHNTime = 0;
my $totalCHNUttTime = 0;
my $totalCHNCryVfxTime = 0;
my $totalCHFTime = 0;
my $totalCXNTime = 0;
my $totalCXFTime = 0;
my $totalNONTime = 0;
my $totalNOFTime = 0;
my $totalOLNTime = 0;
my $totalOLFTime = 0;
my $totalTVNTime = 0;
my $totalTVFTime = 0;
my $totalSILTime = 0;
my $totalConvoTime = 0;
my $totalRecordingTime = 0;
my $totalMANCount = 0;
my $totalMAFCount = 0;
my $totalFANCount = 0;
my $totalFAFCount = 0;
my $totalCHNCount = 0;
my $totalCHNUttCount = 0;
my $totalCHNContainingUttCount = 0;
my $totalCHNCryCount = 0;
my $totalCHNVfxCount = 0;
my $totalCHFCount = 0;
my $totalCXNCount = 0;
my $totalCXFCount = 0;
my $totalNONCount = 0;
my $totalNOFCount = 0;
my $totalOLNCount = 0;
my $totalOLFCount = 0;
my $totalTVNCount = 0;
my $totalTVFCount = 0;
my $totalSILCount = 0;
my $totalConvoCount = 0;
my $totalConvoTurnCount = 0;
my $totalRecordingCount = 0;

while (my $line = <INPUTFILE>) {
	
    chomp($line);
    
    my $startTime = 0;
    my $endTime = 0;
    my $uttTime = 0;
    my $cryVfxTime = 0;
	my $convoTurnCount = 0;
    
    if ($line=~ m/All about the Bars/){
    	last;
    }
    
    if ($line=~ m/Segment spkr="MAN"/){
    	$startTime = $line;
        $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalMANTime = $totalMANTime + $endTime - $startTime;
        $totalMANCount = $totalMANCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    } 
    elsif ($line=~ m/Segment spkr="MAF"/){
    	$startTime = $line;
        $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalMAFTime = $totalMAFTime + $endTime - $startTime;
        $totalMAFCount = $totalMAFCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    } 
    elsif ($line=~ m/Segment spkr="FAN"/){
    	$startTime = $line;
        $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalFANTime = $totalFANTime + $endTime - $startTime;
        $totalFANCount = $totalFANCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    } 
    elsif ($line=~ m/Segment spkr="FAF"/){
    	$startTime = $line;
        $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalFAFTime = $totalFAFTime + $endTime - $startTime;
        $totalFAFCount = $totalFAFCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    } 
    elsif ($line=~ m/Segment spkr="CHN"/){
    	$startTime = $line;
        $endTime = $line;
        $uttTime = $line;
        $cryVfxTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalCHNTime = $totalCHNTime + $endTime - $startTime;
        $totalCHNCount = $totalCHNCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    	$uttTime =~ s/.*childUttLen="PT?//g;
    	$uttTime =~ s/S".*//g;
    	if ($uttTime > 0.00){
    		$totalCHNContainingUttCount = $totalCHNContainingUttCount + 1;
    	}
    	$cryVfxTime =~ s/.*childCryVfxLen="PT?//g;
    	$cryVfxTime =~ s/S".*//g;
    	$totalCHNUttTime = $totalCHNUttTime + $uttTime;
    	$totalCHNCryVfxTime = $totalCHNCryVfxTime + $cryVfxTime;
		$totalCHNUttCount++ while ($line =~ m/startUtt/g);
		$totalCHNCryCount++ while ($line =~ m/startCry/g);
		$totalCHNVfxCount++ while ($line =~ m/startVfx/g);
    }
    elsif ($line=~ m/Segment spkr="CHF"/){
    	$startTime = $line;
        $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalCHFTime = $totalCHFTime + $endTime - $startTime;
        $totalCHFCount = $totalCHFCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    }
    elsif ($line=~ m/Segment spkr="CXN"/){
    	$startTime = $line;
        $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalCXNTime = $totalCXNTime + $endTime - $startTime;
        $totalCXNCount = $totalCXNCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    }
    elsif ($line=~ m/Segment spkr="CXF"/){
    	$startTime = $line;
        $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalCXFTime = $totalCXFTime + $endTime - $startTime;
        $totalCXFCount = $totalCXFCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    }
    elsif ($line=~ m/Segment spkr="NON"/){
    	$startTime = $line;
        $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalNONTime = $totalNONTime + $endTime - $startTime;
        $totalNONCount = $totalNONCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    }
    elsif ($line=~ m/Segment spkr="NOF"/){
    	$startTime = $line;
        $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalNOFTime = $totalNOFTime + $endTime - $startTime;
        $totalNOFCount = $totalNOFCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    }
    elsif ($line=~ m/Segment spkr="OLN"/){
    	$startTime = $line;
        $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalOLNTime = $totalOLNTime + $endTime - $startTime;
        $totalOLNCount = $totalOLNCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    }
    elsif ($line=~ m/Segment spkr="OLF"/){
    	$startTime = $line;
        $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalOLFTime = $totalOLFTime + $endTime - $startTime;
        $totalOLFCount = $totalOLFCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    }
    elsif ($line=~ m/Segment spkr="TVN"/){
    	$startTime = $line;
        $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalTVNTime = $totalTVNTime + $endTime - $startTime;
        $totalTVNCount = $totalTVNCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    }
    elsif ($line=~ m/Segment spkr="TVF"/){
    	$startTime = $line;
        $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalTVFTime = $totalTVFTime + $endTime - $startTime;
        $totalTVFCount = $totalTVFCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    }
    elsif ($line=~ m/Segment spkr="SIL"/){
    	$startTime = $line;
        $endTime = $line;
        $startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
        $totalSILTime = $totalSILTime + $endTime - $startTime;
        $totalSILCount = $totalSILCount+1;
        if ($endTime == $maxsecs){
        	last;
    	}
    }
    elsif (($line=~ m/Conversation num="/) && ($line!~ m/turnTaking="0"/)){
    	$startTime = $line;
    	$endTime = $line;
    	$startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
		$convoTurnCount = $line;
		$convoTurnCount =~ s/.*turnTaking="//g;
		$convoTurnCount =~ s/".*//g;
    	$totalConvoTime = $totalConvoTime + $endTime - $startTime;
    	$totalConvoCount = $totalConvoCount+1;
		$totalConvoTurnCount = $totalConvoTurnCount+$convoTurnCount;
    }
    elsif ($line=~ m/Recording num="/){
    	$startTime = $line;
    	$endTime = $line;
    	$startTime =~ s/.*startTime="PT//g;
        $startTime =~ s/S" endTime=.*//g;
        if ($startTime >=$maxsecs){
        	last;
        } elsif ($startTime < $minsecs){
        	next;
        }
        $endTime =~ s/.*endTime="PT//g;
        $endTime =~ s/S".*//g;
        if ($endTime >= $maxsecs){
        	$endTime = $maxsecs;
    	}
    	$totalRecordingTime = $totalRecordingTime + $endTime - $startTime;
    	$totalRecordingCount = $totalRecordingCount+1;
    }
       
}

print OUTPUTFILE "Item\ttotalTime\ttotalCount\n";
print OUTPUTFILE "MAN\t$totalMANTime\t$totalMANCount\n";
print OUTPUTFILE "MAF\t$totalMAFTime\t$totalMAFCount\n";
print OUTPUTFILE "FAN\t$totalFANTime\t$totalFANCount\n";
print OUTPUTFILE "FAF\t$totalFAFTime\t$totalFAFCount\n";
print OUTPUTFILE "CHN\t$totalCHNTime\t$totalCHNCount\n";
print OUTPUTFILE "CHNUtt\t$totalCHNUttTime\t$totalCHNUttCount\n";
print OUTPUTFILE "CHNContainingUtt\tNA\t$totalCHNContainingUttCount\n";
print OUTPUTFILE "CHNCryVfx\t$totalCHNCryVfxTime\tNA\n";
print OUTPUTFILE "CHNCryVfxCry\tNA\t$totalCHNCryCount\n";
print OUTPUTFILE "CHNCryVfxVfx\tNA\t$totalCHNVfxCount\n";
print OUTPUTFILE "CHF\t$totalCHFTime\t$totalCHFCount\n";
print OUTPUTFILE "CXN\t$totalCXNTime\t$totalCXNCount\n";
print OUTPUTFILE "CXF\t$totalCXFTime\t$totalCXFCount\n";
print OUTPUTFILE "NON\t$totalNONTime\t$totalNONCount\n";
print OUTPUTFILE "NOF\t$totalNOFTime\t$totalNOFCount\n";
print OUTPUTFILE "OLN\t$totalOLNTime\t$totalOLNCount\n";
print OUTPUTFILE "OLF\t$totalOLFTime\t$totalOLFCount\n";
print OUTPUTFILE "TVN\t$totalTVNTime\t$totalTVNCount\n";
print OUTPUTFILE "TVF\t$totalTVFTime\t$totalTVFCount\n";
print OUTPUTFILE "SIL\t$totalSILTime\t$totalSILCount\n";
print OUTPUTFILE "Convo\t$totalConvoTime\t$totalConvoCount\n";
print OUTPUTFILE "ConvoTurns\tNA\t$totalConvoTurnCount\n";
print OUTPUTFILE "Recording\t$totalRecordingTime\t$totalRecordingCount\n";

close(INPUTFILE);
close(OUTPUTFILE);

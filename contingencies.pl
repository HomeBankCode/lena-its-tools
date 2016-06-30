#!/usr/local/bin/perl
#
# Anne S. Warlaumont
# For collaboration with Paul Yoder and Amy Tostanoski
#
# Take the following command line arguments:
# The (path and) file name of the input segments.csv file
# The (path and) csv file name where you want the sequence data to be written
# The (path and) text file name where you want the contingency table data to be written

use strict; use warnings;

open INPUTFILE, $ARGV[0] or die "Could not open input file " . $ARGV[0] . "\r\n";
open OUTPUTFILESEQ, ">", $ARGV[1] or die "Could not open output file " . $ARGV[1] . "\r\n";
open OUTPUTFILECON, ">", $ARGV[2] or die "Could not open output file " . $ARGV[2] . "\r\n";

print OUTPUTFILESEQ "Seg1CHNSP,Seg1CHNNSP,Seg2AN,Seg3CHNSP,Seg3CHNNSP\r\n";

my @segtypes;
my @starttimes;
my @endtimes;
while (my $line = <INPUTFILE>){
	chomp($line);
	my @cols = split(',',$line);
	push(@segtypes,$cols[0]);
	push(@starttimes,$cols[1]);
	push(@endtimes,$cols[2]);
}

# Initialize first order CHNSP contingency table values:
my $con1a = 0;
my $con1b = 0;
my $con1c = 0;
my $con1d = 0;

# Initialize second order CHNSP contingency table values:
my $con2a = 0;
my $con2b = 0;
my $con2c = 0;
my $con2d = 0;

# Initialize second order CHNSP restricted contingency table values:
my $con2resa = 0;
my $con2resb = 0;
my $con2resc = 0;
my $con2resd = 0;

# Initialize first order CHNNSP contingency table values:
my $con1nspa = 0;
my $con1nspb = 0;
my $con1nspc = 0;
my $con1nspd = 0;

# Initialize second order CHNNSP contingency table values:
my $con2nspa = 0;
my $con2nspb = 0;
my $con2nspc = 0;
my $con2nspd = 0;

# Initialize second order CHNNSP restricted contingency table values:
my $con2nspresa = 0;
my $con2nspresb = 0;
my $con2nspresc = 0;
my $con2nspresd = 0;

# Initialize first order CHNonly contingency table values:
my $con1chnonlya = 0;
my $con1chnonlyb = 0;
my $con1chnonlyc = 0;
my $con1chnonlyd = 0;

# Initialize second order CHNonlySP contingency table values:
my $con2chnonlySPa = 0;
my $con2chnonlySPb = 0;
my $con2chnonlySPc = 0;
my $con2chnonlySPd = 0;

# Initialize second order CHNonlyNSP contingency table values:
my $con2chnonlyNSPa = 0;
my $con2chnonlyNSPb = 0;
my $con2chnonlyNSPc = 0;
my $con2chnonlyNSPd = 0;

for (my $linenum = 1; $linenum < (@segtypes-2); $linenum++){

	my $Seg1CHNSP;
	my $Seg1CHNNSP;
	my $Seg2AN;
	my $Seg3CHNSP;
	my $Seg3CHNNSP;
	
	# Find out if the first event in the sequence is a speech-related child segment
	if ($segtypes[$linenum] =~ m/CHNSP/){
		$Seg1CHNSP = "Y";
	}
	else{
		$Seg1CHNSP = "N";
	}
	
	# Find out if the first event in the sequence is a not-speech-related child segment
	if ($segtypes[$linenum] =~ m/CHNNSP/){
		$Seg1CHNNSP = "Y";
	}
	else{
		$Seg1CHNNSP = "N";
	}
	
	# Find out if the second event in the sequence is an adult segment
	if ($segtypes[$linenum+1] =~ m/AN/){
		$Seg2AN = "Y";
	}
	else{
		$Seg2AN = "N";
	}
	
	# Find out if the third event in the sequence is a speech-related child segment
	if ($segtypes[$linenum+2] =~ m/CHNSP/){
		$Seg3CHNSP = "Y";
	}
	else{
		$Seg3CHNSP = "N";
	}
	
	# Find out if the third event in the sequence is a not-speech-related child segment
	if ($segtypes[$linenum+2] =~ m/CHNNSP/){
		$Seg3CHNNSP = "Y";
	}
	else{
		$Seg3CHNNSP = "N";
	}

	print OUTPUTFILESEQ "$Seg1CHNSP,$Seg1CHNNSP,$Seg2AN,$Seg3CHNSP,$Seg3CHNNSP\r\n";
	
	# Update contingency table values:
	
	# Contingency tables that don't specifically contrast CHNSP with  CHNNSP:
	if (($Seg1CHNSP eq "Y")&($Seg2AN eq "Y")){
		$con1a = $con1a + 1;
		if ($Seg3CHNSP eq "Y"){
			$con2a = $con2a + 1;
			$con2resa = $con2resa + 1;
		}
		else {
			$con2b = $con2b + 1;
			$con2resb = $con2resb + 1;
		}
	}
	elsif (($Seg1CHNSP eq "Y")&($Seg2AN eq "N")){
		$con1b = $con1b + 1;
		if ($Seg3CHNSP eq "Y"){
			$con2c = $con2c + 1;
			$con2resc = $con2resc + 1;
		}
		else {
			$con2d = $con2d + 1;
			$con2resd = $con2resd + 1;
		}
	}
	elsif (($Seg1CHNSP eq "N")&($Seg2AN eq "Y")){
		$con1c = $con1c + 1;
		if ($Seg3CHNSP eq "Y"){
			$con2c = $con2c + 1;
		}
		else {
			$con2d = $con2d + 1;
		}
	}
	elsif (($Seg1CHNSP eq "N")&($Seg2AN eq "N")){
		$con1d = $con1d + 1;
		if ($Seg3CHNSP eq "Y"){
			$con2c = $con2c + 1;
		}
		else {
			$con2d = $con2d + 1;
		}
	}
	
	# Contingency tables that focus on child not-speech-related segments (CHNNSP) and don't specifically contrast CHNSP with  CHNNSP:
	if (($Seg1CHNNSP eq "Y")&($Seg2AN eq "Y")){
		$con1nspa = $con1nspa + 1;
		if ($Seg3CHNNSP eq "Y"){
			$con2nspa = $con2nspa + 1;
			$con2nspresa = $con2nspresa + 1;
		}
		else {
			$con2nspb = $con2nspb + 1;
			$con2nspresb = $con2nspresb + 1;
		}
	}
	elsif (($Seg1CHNNSP eq "Y")&($Seg2AN eq "N")){
		$con1nspb = $con1nspb + 1;
		if ($Seg3CHNNSP eq "Y"){
			$con2nspc = $con2nspc + 1;
			$con2nspresc = $con2nspresc + 1;
		}
		else {
			$con2nspd = $con2nspd + 1;
			$con2nspresd = $con2nspresd + 1;
		}
	}
	elsif (($Seg1CHNNSP eq "N")&($Seg2AN eq "Y")){
		$con1nspc = $con1nspc + 1;
		if ($Seg3CHNNSP eq "Y"){
			$con2nspc = $con2nspc + 1;
		}
		else {
			$con2nspd = $con2nspd + 1;
		}
	}
	elsif (($Seg1CHNNSP eq "N")&($Seg2AN eq "N")){
		$con1nspd = $con1nspd + 1;
		if ($Seg3CHNNSP eq "Y"){
			$con2nspc = $con2nspc + 1;
		}
		else {
			$con2nspd = $con2nspd + 1;
		}
	}
	
	# Contingency tables that specifically contrast speech-related vs. not-speech-related child segments:
	if (($Seg1CHNSP eq "Y")&($Seg2AN eq "Y")){
		$con1chnonlya = $con1chnonlya + 1;
		if ($Seg3CHNSP eq "Y"){
			$con2chnonlySPa = $con2chnonlySPa + 1;
		}
		elsif ($Seg3CHNNSP eq "Y"){
			$con2chnonlySPb = $con2chnonlySPb + 1;
		}
	}
	elsif (($Seg1CHNSP eq "Y")&($Seg2AN eq "N")){
		$con1chnonlyb = $con1chnonlyb + 1;
		if ($Seg3CHNSP eq "Y"){
			$con2chnonlySPc = $con2chnonlySPc + 1;
		}
		elsif ($Seg3CHNNSP eq "Y"){
			$con2chnonlySPd = $con2chnonlySPd + 1;
		}
	}
	elsif (($Seg1CHNNSP eq "Y")&($Seg2AN eq "Y")){
		$con1chnonlyc = $con1chnonlyc + 1;
		if ($Seg3CHNNSP eq "Y"){
			$con2chnonlyNSPa = $con2chnonlyNSPa + 1;
		}
		elsif ($Seg3CHNSP eq "Y"){
			$con2chnonlyNSPb = $con2chnonlyNSPb + 1;
		}
	}
	elsif (($Seg1CHNNSP eq "Y")&($Seg2AN eq "N")){
		$con1chnonlyd = $con1chnonlyd + 1;
		if ($Seg3CHNNSP eq "Y"){
			$con2chnonlyNSPc = $con2chnonlyNSPc + 1;
		}
		elsif ($Seg3CHNSP eq "Y"){
			$con2chnonlyNSPd = $con2chnonlyNSPd + 1;
		}
	}
	
}

my $con1csa = 'undefined';
my $con2csa = 'undefined';
my $con2rescsa = 'undefined';
my $con1nspcsa = 'undefined';
my $con2nspcsa = 'undefined';
my $con2nsprescsa = 'undefined';
my $con1chnonlycsa = 'undefined';
my $con2chnonlySPcsa = 'undefined';
my $con2chnonlyNSPcsa = 'undefined';
# Compute the contingency space analysis differences:
if (($con1a+$con1b)>0 && ($con1c+$con1d)) {
	$con1csa = ($con1a/($con1a+$con1b)) - ($con1c/($con1c+$con1d));
}
if (($con2a+$con2b)>0 && ($con2c+$con2d)>0) {
	$con2csa = ($con2a/($con2a+$con2b)) - ($con2c/($con2c+$con2d));
}
if (($con2resa+$con2resb)>0 && ($con2resc+$con2resd)>0) {
	$con2rescsa = ($con2resa/($con2resa+$con2resb)) - ($con2resc/($con2resc+$con2resd));
}
if (($con1nspa+$con1nspb)>0 && ($con1nspc+$con1nspd)>0) {
	$con1nspcsa = ($con1nspa/($con1nspa+$con1nspb)) - ($con1nspc/($con1nspc+$con1nspd));
}
if (($con2nspa+$con2nspb)>0 && ($con2nspc+$con2nspd)>0) {
	$con2nspcsa = ($con2nspa/($con2nspa+$con2nspb)) - ($con2nspc/($con2nspc+$con2nspd));
}
if (($con2nspresa+$con2nspresb)>0 && ($con2nspresc+$con2nspresd)>0) {
	$con2nsprescsa = ($con2nspresa/($con2nspresa+$con2nspresb)) - ($con2nspresc/($con2nspresc+$con2nspresd));
}
if (($con1chnonlya+$con1chnonlyb)>0 && ($con1chnonlyc+$con1chnonlyd)>0) {
	$con1chnonlycsa = ($con1chnonlya/($con1chnonlya+$con1chnonlyb)) - ($con1chnonlyc/($con1chnonlyc+$con1chnonlyd));
}
if (($con2chnonlySPa+$con2chnonlySPb)>0 && ($con2chnonlySPc+$con2chnonlySPd)>0) {
	$con2chnonlySPcsa = ($con2chnonlySPa/($con2chnonlySPa+$con2chnonlySPb)) - ($con2chnonlySPc/($con2chnonlySPc+$con2chnonlySPd));
}
if (($con2chnonlyNSPa+$con2chnonlyNSPb)>0 && ($con2chnonlyNSPc+$con2chnonlyNSPd)>0) {
	$con2chnonlyNSPcsa = ($con2chnonlyNSPa/($con2chnonlyNSPa+$con2chnonlyNSPb)) - ($con2chnonlyNSPc/($con2chnonlyNSPc+$con2chnonlyNSPd));
}

# Print the contingency table data to file
print OUTPUTFILECON "First order Yoder contingency table:\r\n";
print OUTPUTFILECON "CHNSP followed by AN (cell a): $con1a\r\n";
print OUTPUTFILECON "CHNSP followed by not AN (cell b): $con1b\r\n";
print OUTPUTFILECON "not CHNSP followed by AN (cell c): $con1c\r\n";
print OUTPUTFILECON "not CHNSP followed by not AN (cell d): $con1d\r\n";
print OUTPUTFILECON "(a/(a+b)) - (c/(c+d)): $con1csa\r\n\r\n";

print OUTPUTFILECON "Second order Yoder contingency table:\r\n";
print OUTPUTFILECON "CHNSP followed by AN followed by CHNSP (cell a): $con2a\r\n";
print OUTPUTFILECON "CHNSP followed by AN followed by not CHNSP (cell b): $con2b\r\n";
print OUTPUTFILECON "not (CHNSP followed by AN) followed by CHNSP (cell c): $con2c\r\n";
print OUTPUTFILECON "not (CHNSP followed by AN) follwed by not CHNSP (cell d): $con2d\r\n";
print OUTPUTFILECON "(a/(a+b)) - (c/(c+d)): $con2csa\r\n\r\n";

print OUTPUTFILECON "Second order restricted contingency table:\r\n";
print OUTPUTFILECON "CHNSP followed by AN followed by CHNSP (cell a): $con2resa\r\n";
print OUTPUTFILECON "CHNSP followed by AN followed by not CHNSP (cell b): $con2resb\r\n";
print OUTPUTFILECON "CHNSP followed by not AN followed by CHNSP (cell c): $con2resc\r\n";
print OUTPUTFILECON "CHNSP followed by not AN follwed by not CHNSP (cell d): $con2resd\r\n";
print OUTPUTFILECON "(a/(a+b)) - (c/(c+d)): $con2rescsa\r\n\r\n";

print OUTPUTFILECON "First order not-speech-related Yoder contingency table:\r\n";
print OUTPUTFILECON "CHNNSP followed by AN (cell a): $con1nspa\r\n";
print OUTPUTFILECON "CHNNSP followed by not AN (cell b): $con1nspb\r\n";
print OUTPUTFILECON "not CHNNSP followed by AN (cell c): $con1nspc\r\n";
print OUTPUTFILECON "not CHNNSP followed by not AN (cell d): $con1nspd\r\n";
print OUTPUTFILECON "(a/(a+b)) - (c/(c+d)): $con1nspcsa\r\n\r\n";

print OUTPUTFILECON "Second order not-speech-related Yoder contingency table:\r\n";
print OUTPUTFILECON "CHNNSP followed by AN followed by CHNNSP (cell a): $con2nspa\r\n";
print OUTPUTFILECON "CHNNSP followed by AN followed by not CHNNSP (cell b): $con2nspb\r\n";
print OUTPUTFILECON "not (CHNNSP followed by AN) followed by CHNNSP (cell c): $con2nspc\r\n";
print OUTPUTFILECON "not (CHNNSP followed by AN) follwed by not CHNNSP (cell d): $con2nspd\r\n";
print OUTPUTFILECON "(a/(a+b)) - (c/(c+d)): $con2nspcsa\r\n\r\n";

print OUTPUTFILECON "Second order not-speech-related restricted contingency table:\r\n";
print OUTPUTFILECON "CHNNSP followed by AN followed by CHNNSP (cell a): $con2nspresa\r\n";
print OUTPUTFILECON "CHNNSP followed by AN followed by not CHNNSP (cell b): $con2nspresb\r\n";
print OUTPUTFILECON "CHNNSP followed by not AN followed by CHNNSP (cell c): $con2nspresc\r\n";
print OUTPUTFILECON "CHNNSP followed by not AN follwed by not CHNNSP (cell d): $con2nspresd\r\n";
print OUTPUTFILECON "(a/(a+b)) - (c/(c+d)): $con2nsprescsa\r\n\r\n";

print OUTPUTFILECON "First order child speech-related vs. not-speech-related contingency table:\r\n";
print OUTPUTFILECON "CHNSP followed by AN (cell a): $con1chnonlya\r\n";
print OUTPUTFILECON "CHNSP followed by not AN (cell b): $con1chnonlyb\r\n";
print OUTPUTFILECON "CHNNSP followed by AN (cell c): $con1chnonlyc\r\n";
print OUTPUTFILECON "CHNNSP followed by not AN (cell d): $con1chnonlyd\r\n";
print OUTPUTFILECON "(a/(a+b)) - (c/(c+d)): $con1chnonlycsa\r\n\r\n";

print OUTPUTFILECON "Second order child speech-related vs. not-speech-related, focusing on speech-related, contingency table:\r\n";
print OUTPUTFILECON "CHNSP followed by AN followed by CHNSP (cell a): $con2chnonlySPa\r\n";
print OUTPUTFILECON "CHNSP followed by AN followed by CHNNSP (cell b): $con2chnonlySPb\r\n";
print OUTPUTFILECON "CHNSP followed by not AN followed by CHNSP (cell c): $con2chnonlySPc\r\n";
print OUTPUTFILECON "CHNSP followed by not AN followed by CHNNSP (cell d): $con2chnonlySPd\r\n";
print OUTPUTFILECON "(a/(a+b)) - (c/(c+d)): $con2chnonlySPcsa\r\n\r\n";

print OUTPUTFILECON "Second order child speech-related vs. not-speech-related, focusing on not speech-related, contingency table:\r\n";
print OUTPUTFILECON "CHNNSP followed by AN followed by CHNNSP (cell a): $con2chnonlyNSPa\r\n";
print OUTPUTFILECON "CHNNSP followed by AN followed by CHNSP (cell b): $con2chnonlyNSPb\r\n";
print OUTPUTFILECON "CHNNSP followed by not AN followed by CHNNSP (cell c): $con2chnonlyNSPc\r\n";
print OUTPUTFILECON "CHNNSP followed by not AN followed by CHNSP (cell d): $con2chnonlyNSPd\r\n";
print OUTPUTFILECON "(a/(a+b)) - (c/(c+d)): $con2chnonlyNSPcsa\r\n\r\n";

close(INPUTFILE);
close(OUTPUTFILESEQ);
close(OUTPUTFILECON);

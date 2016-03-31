# Gina M. Pretzer
#
# This tool allows you to run the "readits_start_end_content.pl" tool on multiple .its files.
# The output information for each .its file is written into an individual .csv file.
#
# Takes the following command line arguments:
# The path and file for this script (e.g. "~/lena-its-tools/RunFolder_readits.sh")
# 
# Instructions:
# 1.) To use this tool, have all desired .its files in a folder of its own. You may nest folders for each participant within the overall folder. 
#     In this example, the "Participants" folder holds subfolders for each participant where the .its files are stored (e.g. WW01).
# 2.) Enter the path to the main folder containing the desired .its files (e.g. "~/desktop/Gina/Participants"
# 3.) Specify any subfolders within the main folder
#	  All the subfolders are named starting with WW, so the * allows for all the WW folders to be opened 
# 4.) Specify the .its file
# 5.) Name the output file
#	  This adds "_out" to the end of the .its filename, and changes the ".its" suffix to ".csv", since the output file is a .csv file
# 6.) Set the path for the "readits_start_end_content.pl" file (e.g. "~/Desktop/lena-its-tools/readits_start_end_content.pl")
# 7.) Save all changes
# 8.) Launch Terminal
# 9.) Navigate to directory where "RunFolder_readits.sh" is located
# 10.) Run the file (sh RunFolder_readits.sh )


cd /Volumes/Research/WWTranscription/WWTranscriptionProject/Participants/  ## The main folder "Participants" contains the subfolders
for folder in WW*  ## The subfolders are named for each participant, all beginning with "WW"
	do cd $folder
		for itsfile in *.its
			do outfile1=`echo $itsfile | sed 's/\.its/CHNStartEndUttCryTimes\.txt/g'`;
			   outfile2=`echo $itsfile | sed 's/\.its/ANStartAndEndTime\.txt/g'`;
			   outfile3=`echo $itsfile | sed 's/\.its/CHN_AN_Segments\.txt/g'`;  
			   perl ~/Desktop/lena-its-tools/readits_start_end_content.pl $itsfile $outfile1 $outfile2 $outfile3 "IgnoreOverlap" 57600
			done
	cd ..
	done		
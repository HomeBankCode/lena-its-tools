#  Using "get\_binary\_RTs.pl" 

This tool identifies when a sequence of 1 or more child (or adult) segments is produced with no more than 1 second intervening between the segments, find out if an adult (or child) segment followed within 1 second or less.
This program returns two output files. The first output file gives information about the child vocalizations and responses, and the second gives information about the adult vocalizations and responses.
This program requires that you have previously run "readits\_start\_end\_content.pl" on the recording's .its file.

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/Binary_Pic1.jpg "Title")

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/Binary_Pic2.jpg "Title")

How to use "get\_binary\_RTs.pl" on a single .its file (on a Mac):

* Launch Terminal
* Navigate to the directory where "get\_binary\_RTs.pl" is located
   * In the command line type the path to the directory
     * e.g., "~/Desktop/lena-its-tools/"
     
![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/Binary_Pic3.jpg "Title")

* Run “get\_binary\_RTs.pl” with the location and name of the its file as the first argument and the location and name of the desired segments csv output file as the second argument.
  * In the command line, type “get\_binary\_RTs.pl” which calls the script and readies it to run.
  * Next, add the first argument, which is the combined AN and CHN input file created by the "readits\_start\_end\_content.pl" tool.
    * e.g. “~Desktop/Gina/Participants/WW04/e20131126\_15502\2_009145CHN\_AN\_Segments.txt”
  * Continue by typing in the second argument, the path and name file of the child response probability output file.
    * e.g. “~Desktop/Gina/Participants/WW04/e20131126\_155022\_009145ChildResponseProb.txt”
  * Then, add the third argument, which is the path and file name of the adult response probability output file.
    * e.g., "~Desktop/Gina/Participants/WW04/e20131126\_155022\_009145AdultResponseProb.txt"
  * Designate whether turns with overlap in between should be excluded, as the fourth argument.
  	* e.g., "true" for yes and "false" for no
  * Finally, designate the CHN Utt duration cutoff (in seconds), above which a child vocalization is said to consider speech-related material, as the fifth argument.
  	* e.g., "1" 
  * Press Return to run the entire line.
    * e.g. "perl recorderpauses.pl ~Desktop/Gina/Participants/WW04/e20131126\_155022\_009145CHN\_AN\_Segments.txt  ~Desktop/Gina/Participants/WW04/e20131126\_155022\_009145ChildResponseProb.txt ~Desktop/Gina/Participants/WW04/e20131126\_155022\_009145AdultResponseProb.txt true 1"
    
![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/Binary_Pic4.jpg "Title")

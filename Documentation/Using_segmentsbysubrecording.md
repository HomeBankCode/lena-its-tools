# Using "segmentsbysubrecording.pl" # 

This tool identifies the start and end times of segments within subrecordings of a LENA recording. 
A new file containing the start and end times for each segment will be created for each subrecording of the entire recording.
* e.g., e20131210\_144819\_009143CHN\_AN\_Segments1.txt; e20131210\_144819\_009143CHN\_AN\_Segments2.txt; e20131210\_144819\_009143CHN\_AN\_Segments3.txt; e20131210\_144819\_009143CHN\_AN\_Segments4.txt


![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/SegBySub_Pic1.jpg "Title")

Before running this program, you must run:
* readits\_start\_end\_content.pl or segments.pl
* recorderpauses.pl

How to use "segmentsbysubrecording.pl" on a single .its file (on a Mac):

* Launch Terminal
* Navigate to the directory where "segmentsbysubrecording.pl" is located
   * In the command line type the path to the directory
     * e.g., "~/Desktop/lena-its-tools/"
     
![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/SegBySub_Pic2.jpg "Title")

* Run “segmentsbysubrecording.pl” with the location and name of the its file as the first argument, the location and name of the desired segments csv output file as the second argument, and the numbers 1 and 0 or 2 and 1 as the second and third argument, depending on whether you are running this on the output of readits_start_end_content.pl or segments.pl.
  * In the command line, type “perl segmentsbysubrecording.pl” which calls the script and readies it to run.
  * Next, add the first argument, which is the name of the pause times file made from running “recorderpauses.pl”.
    * e.g. “~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145\_PauseTimes.txt”
  * Continue by typing in the second argument, which is the path and name of the segment times input file created by "readits\_start\_end\_content.pl".
    * e.g. “~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145CHN\_AN\_Segments.txt”
   * Next, if you are running this on the output of readits_start_end_content.pl, add "1" and "0" as the third and fourth arguments. Or if you are running it on the output of segments.pl, add "2" and "1".
  * Press Return to run the entire line.
    * e.g. “perl segmentsbysubrecording.pl ~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145\_PauseTimes.txt ~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145CHN\_AN\_Segments.txt 1 0"
    * OR
    * "perl segmentsbysubrecording /PathToPauseTimesFile/e20131126_15502_009145_PauseTimes.txt /PathToOutputOfSegmentsDotPl/e20131126_15502_009145_Segments.txt 2 1"
    * Note that the numbers as 3rd and 4th input arguments are new, and aren't shown in the screenshot below.
    
![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/SegBySub_Pic3.jpg "Title")

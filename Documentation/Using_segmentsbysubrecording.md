# Using "segmentsbysubrecording.pl" # 

This tool identifies the start and end times of segments within subrecordings of a LENA recording. 
A new file containing the start and end times for each segment will be created for each subrecording of the entire recording.
* e.g., e20131210\_144819\_009143CHN\_AN\_Segments1.txt; e20131210\_144819\_009143CHN\_AN\_Segments2.txt; e20131210\_144819\_009143CHN\_AN\_Segments3.txt; e20131210\_144819\_009143CHN\_AN\_Segments4.txt


![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/SegBySub_Pic1.jpg "Title")

Before running this program, you must run:
* readits\_start\_end\_content.pl
* recorderpauses.pl

How to use "segmentsbysubrecording.pl" on a single .its file (on a Mac):

* Launch Terminal
* Navigate to the directory where "segmentsbysubrecording.pl" is located
   * In the command line type the path to the directory
     * e.g., "~/Desktop/lena-its-tools/"
     
![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/SegBySub_Pic2.jpg "Title")

* Run “segmentsbysubrecording.pl” with the location and name of the its file as the first argument and the location and name of the desired segments csv output file as the second argument.
  * In the command line, type “perl segmentsbysubrecording.pl” which calls the script and readies it to run.
  * Next, add the first argument, which is the name of the pause times file made from running “recorderpauses.pl”.
    * e.g. “~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145\_PauseTimes.txt”
  * Continue by typing in the second argument, which is the path and name of the segment times input file created by "readits\_start\_end\_content.pl".
    * e.g. “~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145CHN\_AN\_Segments.txt”
  * Press Return to run the entire line.
    * e.g. “perl segmentsbysubrecording.pl ~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145\_PauseTimes.txt ~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145CHN\_AN\_Segments.txt
    
![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/SegBySub_Pic3.jpg "Title")

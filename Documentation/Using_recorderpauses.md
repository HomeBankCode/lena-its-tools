# Using "recorderpauses.pl" #

# This tool allows you to find out the exact time(s) a recorder was paused. 
# This is useful when looking at an event series and determining whether the time between vocalizations are really an absence of speech or just periods of time when the recorder was paused.

[alt text](https://github.com/gpretzer/DocumentationPics/blob/master/RecorderPauses_Pic1.jpg "Title")

How to use "recorderpauses.pl" on a single .its file (on a Mac):

* Launch Terminal
* Navigate to the directory where "recorderpauses.pl" is located
   * In the command line type the path to the directory
     * e.g., "~/Desktop/lena-its-tools/"
     
![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/RecorderPauses_Pic2.jpg "Title")

* Run “recorderpauses.pl” with the location and name of the its file as the first argument and the location and name of the desired segments csv output file as the second argument.
  * In the command line, type “perl segments.pl” which calls the script and readies it to run.
  * Next, add the first argument, which is the name of the its file you will use to run the “recorderpauses.pl”.
    * e.g. “~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145.its”
  * Continue by typing in the second argument, which is the path and name of the output .txt file.
    * e.g. “~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145\_PauseTimes.txt”
  * Press Return to run the entire line.
    * e.g. “perl recorderpauses.pl ~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145.its ~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145\_PauseTimes.txt”
    
![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/RecorderPauses_Pic3.jpg "Title")
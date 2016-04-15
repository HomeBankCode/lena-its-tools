# Using "segments.pl" #

The “segments.pl” script allows you to get specific information about each vocalization in a LENA recording, using the .its file. The output .csv file will have columns indicating the type of vocalization, as well as the start and end times of each vocalization.

![alt text](/https://github.com/gpretzer/DocumentationPics/blob/master/Segments_Pic1.jpg "Title")

How to use "segments.pl" on a single .its file (on a Mac):

1. Launch Terminal
2. Navigate to the directory where "segments.pl" is located
   * In the command line type the path to the directory
     * e.g., "~/Desktop/lena-its-tools/"
     * ![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/Segments_Pic2.jpg "Title")
3. Run “segments.pl” with the location and name of the its file as the first argument and the location and name of the desired segments csv output file as the second argument.
  * In the command line, type “perl segments.pl” which calls the script and readies it to run.
  * Next, add the first argument, which is the name of the its file you will use to run the “segment.pl”.
    * e.g. “~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145.its”
  * Continue by typing in the second argument, which is the path and name of the output .csv file.
    * e.g. “~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145\_segments.csv”
  * Press Return to run the entire line.
    * e.g. “perl segments.pl ~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145.its ~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145\_segments.csv”
    * ![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/Segments_Pic3.jpg "Title")



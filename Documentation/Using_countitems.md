# Using “readits_count_items.pl” #


The “readits\_count\_items.pl” script allows you to input an .its file and create a .txt output file with the total duration and frequency (count) of various events.

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/CountItems_Pic1.jpg "Title")

How to use “readits\_count\_items.pl” on a Mac:

* Launch Terminal
* Navigate to the directory where “readits\_count\_items.pl” is located
   * In the command line type the path to the directory
     * e.g. “~/Desktop/lena-its-tools/”

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/CountItems_Pic2.jpg "Title")

* Run “readits\_count\_items.pl” as follows:
   * In the command line, type “perl readits\_count\_items.pl” which calls the script and readies it to run.
   * Next, add the first argument, which is the name of the its file you will use to run “readits\_count\_items.pl”.
      * e.g. “~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145.its”
   * Continue by typing in the second argument, which is the path and name of the output .csv file.
      * e.g. “~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145\_countitems.csv”
   * Type the next argument, which is the maximum length the recording should be truncated at (in seconds).
      * e.g. “57600” (16 hours)
   * Type the final argument, which is the start time of when to start counting 
      * e.g. To start at the beginning, type 0
   * Press Return to run the entire line.
      * e.g. “perl segments.pl ~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145.its ~/Desktop/Gina/Participants/WW04/e20131126\_155022\_009145\_countitems.csv”

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/CountItems_Pic3.jpg "Title")


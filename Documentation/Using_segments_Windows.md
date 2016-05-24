# Using "segments.pl" #

The “segments.pl” script allows you to get specific information about each vocalization in a LENA recording, using the .its file. The output .csv file will have columns indicating the type of vocalization, as well as the start and end times of each vocalization.
This output format is useful for sequence analyses.

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/Segments_Pic1.jpg "Title")

How to use "segments.pl" on a single .its file (on a Windows machine):

* Open Command prompt
* Navigate to the directory where "segments.pl" is located
   * In the command line type the path to the directory
     * e.g., "cd Desktop/lena\-its\-tools\-master/Example"
     
![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/segmentspic2.JPG "Title")

* Run “segments.pl” with the location and name of the its file as the first argument and the location and name of the desired segments csv output file as the second argument.
  * In the command line, type “perl segments.pl” which calls the script and readies it to run.
  * Next, add the first argument, which is the name of the its file you will use to run the “segment.pl”.
    * e.g. “e20160420\_165405\_010572.its”
  * Continue by typing in the second argument, which is the path and name of the output .csv file.
    * e.g. “segments.csv”
  * Press Return to run the entire line.
    * e.g. “perl segments.pl e20160420\_165405\_010572.its segments.csv”
    
![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/segmentspic3.JPG "Title")

* The output .csv file will save in the same folder that holds the .its file and script.

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/segmentspic4.JPG "Title")

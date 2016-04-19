Using “readits\_start\_end\_content.pl”


The “readits\_start\_end\_content.pl” script allows you to input an .its file and create new output files with 1.) Child vocalization start and end times, as well as the duration of speech related (utt) and not speech related (cry) vocalizations; 2.) Adult vocalization start and end times; and 3.) Child vocalization start and end times, as well as the duration of speech related (utt) and not speech related (cry) vocalizations, **AND** Adult vocalization start and end times. Output files will be saved in the same folder where the input file is located.

Output 1:

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/Readits_Pic1.jpg "Title")

The columns are: CHN Start Time, CHN End Time, Duration (if speech related), Duration (if cry)

Output 2:

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/Readits_Pic2.jpg "Title")

The columns are:  AN Start Time, AN End Time

Output 3: 

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/Readits_Pic3.jpg "Title")

The columns are: Type of Vocalization (AN or CHN), Start Time of Utterance, End Time of Utterance, Duration (if speech related), Duration (if cry)


How to use "readits\_start\_end\_content.pl" on a Mac:

* Launch Terminal
* Navigate to the directory where "readits\_start\_end\_content.pl" is located
  * In the command line type the path to the dirctory
    * e.g., "~/Desktop/lena-its-tools/"

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/Readits_Pic4.jpg "Title")

* Run "readits\_start\_end\_content.pl" as follows:
  * In the command line, type "perl readits\_start\_end\_content.pl" which calls the script and readies it to run.
  * Next, add the path and file name of the input file, which is the first argument.
    * e.g., "e20131126\_155022\_009145.its”
  * The child output file is the second argument. Type the desired path and file name for the output file into the command line.
    * e.g., “CHNStartEndUttCryTimes\_e20131126\_155022\_009145.txt”
  * Next, add the third argument, which is the adult output file. Type the desired path and file name for the output file into the command line. 
    * e.g., “ANStartAndEndTimes\_e20131126\_155022\_009145.txt”
  * Add the fourth argument, which is the combined child and adult output file. Type the desired path and file name for the output file into the command line.
    * e.g., “CHN\_AN\_Segments\_e20131126\_155022\_009145.txt”
  * Continue by adding the mode for dealing with overlap, which is the fifth argument.
    * Options: “IgnoreOverlap”, “TreatOverlapAsAdult”, “TreatOverlapAsChild”, “DeleteOverlap”, “IncludeOverlapExcludeIntervening”, or “IncludeOverlapIgnoreIntervening”.
    * "IgnoreOverlap" is recommended
  * Type the final argument, which is the maximum length the recording should be truncated at (in seconds).
    * e.g., "57600" (for 16 hour recording)
  * Press return to run the entire command.
    * e.g. “perl readits\_start\_end\_content.pl e20131126\_155022\_009145.its CHNStartEndUttCryTimes\_e20131126\_155022\_009145.txt ANStartAndEndTimes\_e20131126\_155022\_009145.txt CHN\_AN\_Segments\_e20131126\_155022\_009145.txt IgnoreOverlap 57600”

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/Readits_Pic5.jpg "Title")



# Using “RunFolder_Segments.sh” #


The “RunFolder\_segments.sh” script allows you to run the “segments.pl” script on an entire folder of .its files. This script will create an output .csv file will have columns indicating the type of vocalization, as well as the start and end times of each vocalization for each individual .its file in a designated folder. This output format is convenient for sequence analyses. 
For more information about running the “segments.pl” file, see "Using\_segments.md".

How to use “RunFolder\_segments.sh” on multiple .its files in a folder (on a Mac):

* Open “RunFolder\_segments.sh” in a text editor, such as Text Wrangler.
   * Follow the instructions in the script to customize to your own folders and subfolders.
* Launch Terminal
* Navigate to the directory where “RunFolder\_Segments.sh” is located
   * In the command line type the path to the directory
      * e.g. “~/Desktop/lena-its-tools/”

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/RunFolder_Segments_Pic1.jpg "Title")

* Run “RunFolder\_readits.sh” as follows:
   * Type “sh RunFolder\_readits.sh” into the command line and press return

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/RunFolder_Segments_Pic2.jpg "Title")

* Output files for each .its file will be saved in the same subfolder that holds the .its file

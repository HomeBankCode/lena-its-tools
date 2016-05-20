# Using “RunFolder\_readits.sh” #

The “RunFolder\_readits.sh” script allows you to run the “readits\_start\_end\_content.pl” script on an entire folder of .its files. This script will create an output .csv file will have columns indicating the type of vocalization, as well as the start and end times of each vocalization for each individual .its file in a designated folder. 
For more information about running the “readits\_start\_end\_content.pl” file, see [Using_readits.md](https://github.com/HomeBankCode/lena-its-tools/blob/master/Documentation/Using\_readits.md "Title")

How to use “RunFolder_readits.sh” on a Mac:

* Open “RunFolder_readits.sh” in a text editor, such as Text Wrangler
  * Follow the instructions in the script to customize to your own folders and subfolders.
* Launch Terminal
  * Navigate to the directory where “RunFolder\_readits.sh” is located
    * In the command line type the path to the directory
      * e.g. “~/Desktop/lena-its-tools/”

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/RunFolder_readits_Pic1.jpg "Title")

  * To run the program, type "sh RunFolde_readits.sh" into the command line
 
 ![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/RunFolder_readits_Pic2.jpg "Title")
 
* Output files for each .its file will be saved in the same subfolder that holds the .its file 
# Using "getIndividualAudioSegments.m" 

Before running this program, run the "readits\_start\_end\_content.pl" program on the recording .its file
You will use the combined AN and CHN file as input for this program

You can save each segment as its own .wav file by uncommenting line 23.
You can play the individual segments by uncommenting lines 26-27

How to use "getIndividualAudioSegments" (on a Mac):

* Navigate to the directory that contains the combined AN and CHN .txt file that was created by running "readits\_start\_end\_content.pl"
  * Create a folder named "Segments" within that directory
* Launch Matlab
  * Open "getIndividualAudioSegments.m"
  * In the command window, type: getIndividualAudioSegments(StartEndFile,bigWavFile,OutFileBase,buffer) where:
  	* StartEndFile = The name of the combined AN and CHN .txt file
  	  * '~/Desktop/Gina/Participants/WW05/e20131210\_144819\_009143CHNStartEndUttCryTimes.txt'
    * bigWavFile = The full .wav file of the recording
      * '~/Desktop/Gina/Participants/WW05/e20131210\_144819\_009143.wav'
    * OutFileBase = Where audio segments will be written (the "Segments" folder created in Step 1)
      * '~/Desktop/Gina/Participants/WW05/Segments/e20131210\_144819\_009143' (this sends the individual .wav files to the "Segments" folder)
    * buffer = should be in seconds and will add some time to the beginning and ending of each audio segment before extracting it 
      * e.g., '1'
    * e.g., '~/Desktop/Gina/Participants/WW05/e20131210\_144819\_009143CHN\_AN\_Segments.txt','~/Desktop/Gina/Participants/WW05/e20131210\_144819\_009143.wav','~/Desktop/Gina/Participants/WW05/Segments/e20131210\_144819\_009143','1');
  * Press Return
    
![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/GetIndivAudio_Pic1.jpg "Title")



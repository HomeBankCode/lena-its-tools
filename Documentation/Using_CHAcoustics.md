# Using "getCHAcousticsTS.m" #

Assumes you have run "getIndividualAudioSegments.m"

Before running this program, run the "getIndividualAudioSegments.m" program on the recording's combined AN and CHN file.
This program will run on the audio segments you created in the "Segments" folder 

The output file will contain the segment type and the start and end time (in seconds) of each segment.

![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/CHacousticsTS_Pic1.jpg "Title")

How to use "getCHAcousticsTS.m" (on a Mac):

* Be sure you have downloaded the "getPraatAcoustics.m" script, as this script calls upon it.
* Launch Matlab
  * Open "getCHAcousticsTS.m"
  * In the command window, type: getCHacousticsTS(StartEndFile,wavFileDir,wavfilebase,outFile) where:
    * StartEndFile = The name of the combined AN and CHN .txt file
      * e.g., '~/Desktop/Gina/Participants/WW05/e20131210\_144819\_009143CHNStartEndUttCryTimes.txt'
    * wavFileDir = The directory where the audio segments were created ("Segments" folder)
      * e.g., '~/Desktop/Gina/Participants/WW05/Segments/e20131210\_144819\_009143'
    * wavfilebase = The name base for the .wav file segments
      * e.g., 'e20131210\_144819\_009143' 
    * outFile = The path and name of the output file                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            = Should be in seconds and will add some time to the beginning and ending of each audio segment before extracting it 
         e.g.,'~/Desktop/Gina/Participants/WW05/e20131210\_144819\_009143CHAcoustics\_Output.txt'
     e.g., getCHacousticsTS('~/Desktop/Gina/Participants/WW05/e20131210\_144819\_009143CHNStartEndUttCryTimes.txt','~/Desktop/Gina/Participants/WW05/Segments/','e20131210\_144819\_009143','~/Desktop/Gina/Participants/WW05/e20131210\_144819\_009143CHAcoustics_Output.txt');
  * Press Return
    
![alt text](https://github.com/gpretzer/DocumentationPics/blob/master/CHacousticsTS_Pic2.jpg "Title")



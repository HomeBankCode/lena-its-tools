# lena-its-tools
This repository hosts a set of tools for working with LENA ITS files. These tools use LENA ITS files as input and will create output files for analysis.  More detailed instructions and documentation for select files are located at: https://github.com/HomeBankCode/lena-its-tools/tree/master/Documentation

readits_start_end_content.pl: A Perl script that takes a LENA ITS file as input and saves a new file that contains a list of child and adult start and end times, and for child segments, what duration is speech related and what duration is not speech related.

segments.pl: A Perl script that takes a LENA ITS file as input and saves a new file that contains a list of all segment types and their start and end times as output.

readits_count_items.pl: A Perl script that takes a LENA ITS file as input and saves a new file that summarizes how frequent various events (e.g. speaker segments, conversations, subrecordings) were.

get_binary_RTs.pl: A Perl script that classifies child segments according to whether they received an adult response within 1 s and vice versa.

getIndividualAudioSegments.m: A MATLAB program that plays or saves the waveforms for all the segments from a given speaker for a given pair of ITS and WAV files.

getCHAcousticsTS.m: A MATLAB program that gets some basic acoustics (pitch, intensity, and duration) for all the target child segments in a given LENA recording. Assumes readits_start_end_content.pl and getIndividualAudioSegments.m have already been run. Requires getPraatAcoustics.m.

getPraatAcoustics.m: A MATLAB program that calls Praat to get pitch, intensity, and duration for a given WAV file.

its_anonymization: A directory containing programs, and documentation, to remove identifying information from  one or multiple LENA ITS files. Developed by Melanie Soderstrom's babylanguagelab, https://github.com/babylanguagelab.

RunFolder_segments.sh: This a shell script that allows you to run "segments.pl" on an entire folder of LENA ITS files. This will create an output CSV file that contains a list of all segment types and their start and end times.

RunFolder_readits.sh: This is a shell script that allows you to run "readits_start_end_content.pl" on an entire folder of LENA ITS files. This will create a new output file for each input file with: 1) Child vocalization start and end times with duration of what is speech related and what is not speech related; 2) Adult vocalization start and end times; and 3) Child vocalization start and end times with duration of what is speech related and what is not speech related AND adult vocalization start and end times.

#### segment_v2.py script

This script requires lxml, pandas and pydub to be installed. To do so, run `pip install lxml pandas pydub` (use `pip3` if you are working with Python 3). The script is compatible with both Python 2 and Python 3.

`$ python segment_v2.py path/to/directory/containing/wav_and_its/ name_of_babble_corpora.csv [i]`

Looks at all its files in one directory and creates 100 chn wav chunks randomly chosen. These new wav files are stored in the directory output, situated in the working directory. Add the option `y` to create intermediary files (that is one csv file containing all the CHN utterances' timestamps, and one csv file containing the 100 chosen CHN utterances' timestamps).

Inside this script, each step is a function that can be used independently if need be in a separate python script.

There are several steps that you need to follow for the whole pipeline to work:
- in the babble corpora spreadsheet, fill out the its_filename column with the name of the corresponding its files for each of the 10 lines
- locally, create a directory in which to store the 10 its files, as well as the 10 corresponding .wav, __all in the same directory__; the .wav file __must have the same name__ as the corresponding .its file
- download the BabbleCorpus_ViableParticipants by going in ‘File’ (top left corner), ‘Download as’, then choose the option that outputs a .csv file; move this .csv file in the directory created at the previous step and rename it so that the name does not contain spaces anymore (for example: ‘BabbleCorpora.csv’)

The directory you created should contain something like:
- file1.its
- file1.wav
- file2.its
- file2.wav
- …
- BabbleCorpora.csv

Make sure that file1.its, file2.its… are actually the names you wrote in the spreadsheet. If not, either correct the spreadsheet online and repeat the downloading step, or modify the name of your file to match the name in the spreadsheet.

# lena-its-tools
A set of tools for working with LENA ITS files.

readits_start_end_content.pl: A Perl script that takes a LENA ITS file as input and saves a new file that contains a list of child and adult start and end times, and for child segments, what duration is speech related and what duration is not speech related.

segments.pl: A Perl script that takes a LENA ITS file as input and saves a new file that contains a list of all segment types and their start and end times as output.

readits_count_items.pl: A Perl script that takes a LENA ITS file as input and saves a new file that summarizes how frequent various events (e.g. speaker segments, conversations, subrecordings) were.

get_binary_RTs.pl: A Perl script that classifies child segments according to whether they received an adult response within 1 s and vice versa.

getIndividualAudioSegments.m: A MATLAB program that plays or saves the waveforms for all the segments from a given speaker for a given pair of ITS and WAV files.

getCHAcousticsTS.m: A MATLAB program that gets some basic acoustics (pitch, intensity, and duration) for all the target child segments in a given LENA recording. Assumes readits_start_end_content.pl and getIndividualAudioSegments.m have already been run. Requires getPraatAcoustics.m.

getPraatAcoustics.m: A MATLAB program that calls Praat to get pitch, intensity, and duration for a given WAV file.

its_anonymization: A directory containing programs, and documentation, to remove identifying information from  one or multiple LENA ITS files. Developed by Melanie Soderstrom's babylanguagelab, https://github.com/babylanguagelab.

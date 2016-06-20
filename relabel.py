# Using the output of segments.pl, play all segments meeting certain criteria, prompt the user to relabel who is speaking, and save output to a CSV file.

import scipy.io.wavfile

def relabel_human_near(segmentsfile,wavfile,outfile,coding_start_time,coding_end_time):
    
    # Correct the segments that are labeled as containing human voices that are "near" (i.e. not too similar to LENA's silence model)
    
    # Iterate through the rows:
        # If the segment end time is > coding_start_time
        # If the segment start time is < coding_start_time, play only from coding_start_time to the segment end time 
        # If the row is a "near" human speaker
        # Have the human listener enter a keystroke first to indicate they are ready.
        # Play the sound
        # Allow the human listener to enter the correct label or replay the sound.
        # Append the correct speaker label as a new row in the outfile.
        # If the segment end time is > coding_end_time, play only from the segment start time to coding_end_time
        # If the segment start time is > coding_end_time
    
    outf = open(outfile,'w')
    segments = open(segmentsfile) # Load the file containing the LENA speaker segment labels and their start and end times
    next(segments) # Ignore the header line
    for line in segments:
        
    segments.close()
    outf.close()
    
    return
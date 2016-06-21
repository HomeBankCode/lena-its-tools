# Using the output of segments.pl, play all segments meeting certain criteria, prompt the user to relabel who is speaking, and save output to a CSV file.

import pyglet, scipy.io.wavfile

def relabel_human_near(segmentsfile,wavfile,outfile,coding_start_time,coding_end_time):
    
    # Correct the segments that are labeled as containing human voices that are "near" (i.e. not too similar to LENA's silence model)
    
    # May want to rethink this whole approach, as I'm finding in my pilot listening that the LENA automated labels are very, very inaccurate, at least in the daycare context. It might be better to do frame by frame coding with frames of 50 ms, 100 ms, or 500 ms, or even 1 s. And should we try to distinguish different teachers from each other? We probably could get the main 4 teachers, or maybe even more detail, especially if the same person is coding the full day.
    
    # Iterate through the rows:
        # If the segment end time is > coding_start_time
        # If the segment start time is < coding_start_time, play only from coding_start_time to the segment end time 
        # If the row is a "near" human speaker
        # Have the human listener enter a keystroke first to indicate they are ready.
        # Play the sound
        # Allow the human listener to enter the correct label or replay the sound.
        # Append the correct speaker label as a new row in the outfile.
        # If the segment end time is > coding_end_time, play only from the segment start time to coding_end_time
        # If the segment start time is > coding_end_time, quit
    
    sr, sounddata = scipy.io.wavfile.read(wavfile)
    outf = open(outfile,'w')
    segments = open(segmentsfile) # Load the file containing the LENA speaker segment labels and their start and end times
    next(segments) # Ignore the header line
    for line in segments:
        line = line.rstrip()
        print(line)
        linedata = line.split(",")
        speaker = linedata[0]
        segstart = float(linedata[1])
        segend = float(linedata[2])
        if segend > coding_start_time:
            if segstart > coding_end_time:
                break
            if segstart < coding_start_time:
                playstart = coding_start_time
            else:
                playstart = segstart
            if segend > coding_end_time:
                playend = coding_end_time
            else:
                playend = segend
            segsounddata = sounddata[playstart*sr:playend*sr]
            scipy.io.wavfile.write('temp.wav',sr,segsounddata)
            pygsound = pyglet.media.load('temp.wav',streaming=False)
            raw_input("Press Enter to play the sound")
            pygsound.play()
    segments.close()
    outf.close()
    
    return
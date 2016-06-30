# Using the output of segments.pl, play all segments meeting certain criteria, prompt the user to relabel who is speaking, and save output to a CSV file.

import pyglet, scipy.io.wavfile, numpy

def relabel_by_timebin(wavfile,outfile,coding_start_time,coding_end_time,bin_size):
    
    # Label a child wav file in bins, asking whether or not each speaker type was present (including during overlap)
    # Speaker types include: C (child wearing the recorder), X (other child), A (adult)
    
    sr, sounddata = scipy.io.wavfile.read(wavfile)
    outf = open(outfile,'w')

    for playstart in numpy.arange(coding_start_time,coding_end_time,bin_size):
        if playstart+bin_size > coding_end_time:
            playend = coding_end_time
        else:
            playend = playstart+bin_size
        segsounddata = sounddata[playstart*sr:playend*sr]
        scipy.io.wavfile.write('temp.wav',sr,segsounddata)
        pygsound = pyglet.media.load('temp.wav',streaming=False)
        raw_input("Press Enter to play the sound")
        pygsound.play()
        raw_input("Please enter the codes (no spaces between) for the types of voices you heard in the segment that just played. Codes: C for child wearing the recorder, X for another child, A for adult. Press enter when you are done entering the codes, then the next sound snippet will automatically play.")
    
    outf.close()
    
    return
    
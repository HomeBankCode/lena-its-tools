# Using the output of segments.pl, play all segments meeting certain criteria, prompt the user to relabel who is speaking, and save output to a CSV file.

import pyglet, scipy.io.wavfile, numpy

def relabel_by_timebin(wavfile,outfile,coding_start_time,coding_end_time,bin_size):
    
    # Label a child wav file in bins, asking whether or not each speaker type was present (including during overlap)
    # Speaker types include: C (child wearing the recorder), X (other child), A (adult)
    
    sr, sounddata = scipy.io.wavfile.read(wavfile)
    outf = open(outfile,'w')
    outf.write('startSeconds,endSeconds,userInput,containsTargetChild,containsOtherChild,containsAdult\n')
    
    for playstart in numpy.arange(coding_start_time,coding_end_time,bin_size):
        if playstart+bin_size > coding_end_time:
            playend = coding_end_time
        else:
            playend = playstart+bin_size
        segsounddata = sounddata[playstart*sr:playend*sr]
        scipy.io.wavfile.write('temp.wav',sr,segsounddata)
        pygsound = pyglet.media.load('temp.wav',streaming=False)
        raw_input("\nPress Enter to play the sound. Listen carefully because you will only get one opportunity to listen.")
        pygsound.play()
        userInput = raw_input("\nPress control+c to quit the labeling session.\n\n***Instructions***\nPlease enter the codes (no spaces between) for the types of voices you heard in the segment that just played.\nCodes: t for child wearing the recorder, o for another child, a for adult.\nIf there are multiple voices present, enter the multiple codes without spaces in between.\nOrder of the codes does not matter.\nLeave the codes blank if you didn't hear any voices. \n\nType the codes for the voices you heard here, then press return: ")
        containsTargetChild = "t" in userInput
        containsOtherChild = "o" in userInput
        containsAdult = "a" in userInput
        outf.write(str(playstart) + ',' + str(playend) + ',' + userInput + ',' + str(containsTargetChild) + ',' + str(containsOtherChild) + ',' + str(containsAdult) + '\n')
        # To do: Make it so that if outfile already exists, it picks up the coding from where the listener left off.
        
    outf.close()
    
    return
    
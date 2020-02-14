# Tools for huamn listeners to manually identify sound types

import pyglet, scipy.io.wavfile, numpy, os.path

def relabel_by_timebin(wavfile,outfile,coding_start_time,coding_end_time,bin_size):
    
    # Label a child wav file in bins, asking whether or not each speaker type was present (including during overlap)
    # Speaker types include: C (child wearing the recorder), X (other child), A (adult)
    
    sr, sounddata = scipy.io.wavfile.read(wavfile)
    
    # If the output file already exists, use it to get set coding_start_time to pick up where last left off, and append to the output file rather than rewriting it. If the output file does not already exist, create it and the header line.
    if os.path.isfile(outfile):
        outf = open(outfile,'r')
        outfLines = outf.readlines()
        if len(outfLines)>1:
            lastOutfLine = outfLines[-1]
            coding_start_time = float(lastOutfLine.split(',')[0]) + bin_size 
        outf.close()
        outf = open(outfile,'a')
    else:
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
        raw_input("\n***Instructions***\n\nListen carefully because you will only get one opportunity to listen.\nBe on the lookout for any clearly audible vocalization that is primarily\ncommunicative or playful, such as speech, babble, cooing, crying, sighing,\nlaughing, raspberries, clicks, etc. Please ignore vegetative sounds,\nsuch as heavy breathing, hiccups, sneezes, sniffles, and coughs, unless they\nappear to have been produced with a communicative or playful purpose). You\nwill be asked to enter the codes (no spaces between) for the types of voices\nyou heard in the segment that just played.\n\nCodes: t for child wearing the recorder, o for another child, a for adult.\nIf there are multiple voices present, enter the multiple codes without spaces\nin between. Order of the codes does not matter. Leave the space blank if\nyou didn't hear any communicative or playful vocalizations.\n\nPress Enter to play the sound. Press control+c to quit the labeling session.")
        pygsound.play()
        userInput = raw_input("\nType the codes for the voices you heard here, then press return: ")
        containsTargetChild = "t" in userInput
        containsOtherChild = "o" in userInput
        containsAdult = "a" in userInput
        outf.write(str(playstart) + ',' + str(playend) + ',' + userInput + ',' + str(containsTargetChild) + ',' + str(containsOtherChild) + ',' + str(containsAdult) + '\n')
        
    outf.close()
    
    return

def relabel_by_segment(wavfile,outfile,segmentsfile)
    
    # Using the output of segments.pl,
    # play all segments meeting certain criteria,
    # prompt the user to relabel who is speaking,
    # and save output to a CSV file.
    
# Tools for huamn listeners to manually identify sound types

import pyglet, scipy.io.wavfile, numpy, os.path, csv

def relabel_by_timebin(wavfile,outfile,coding_start_time,coding_end_time,bin_size):
    
    # Label a child wav file in bins, asking whether or not each speaker type was present (including during overlap)
    
    sr, sounddata = scipy.io.wavfile.read(wavfile)
    
    # If the output file already exists,
    # use it to set coding_start_time to pick up where last left off,
    # and append to the output file rather than rewriting it.
    # If the output file does not already exist,
    # create it and the header line.
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
        input(('\n***Instructions***\n\nListen carefully because you will only '
              'get one opportunity to listen.\nBe on the lookout for any '
              'clearly audible vocalization that is primarily communicative '
              'or playful, such as speech, babble, cooing, crying, sighing,'
              'laughing, raspberries, clicks, etc. Please ignore vegetative '
              'sounds, such as heavy breathing, hiccups, sneezes, sniffles, '
              'and coughs, unless they appear to have been produced with a '
              'communicative or playful purpose). You will be asked to enter '
              'the codes (no spaces between) for the types of voices you '
              'heard in the segment that just played.\n\nCodes: t for child '
              'wearing the recorder, o for another child, a for adult.\n\nIf '
              'there are multiple voices present, enter the multiple codes '
              'without spaces in between. Order of the codes does not matter.'
              ' Leave the space blank if you did not hear any communicative '
              'or playful vocalizations.\n\nPress return to play the sound. '
              'Press control+c to quit the labeling session.'))
        pygsound.play()
        userInput = input("\nType the codes for the voices you heard here, then press return: ")
        containsTargetChild = "t" in userInput
        containsOtherChild = "o" in userInput
        containsAdult = "a" in userInput
        outf.write(str(playstart) + ',' + str(playend) + ',' + userInput + ',' + str(containsTargetChild) + ',' + str(containsOtherChild) + ',' + str(containsAdult) + '\n')
        
    outf.close()
    
    return

def relabel_by_segment(wavfile,outfile,segmentsfile):
    
    # Using the output of segments.pl,
    # play all segments meeting certain criteria,
    # prompt the user to relabel who is speaking,
    # and save output to a CSV file.
    # Speaker types to be relabeled include:
    # C (child wearing the recorder), X (other child), and A (adult)
    
    return

def relabel_CHN(wavfile,outfile,segmentsfile):
    
    # Using the output of segments.pl,
    # play all the CHN segments,
    # ask the user if the sound contained the target child and nothing else,
    # and save output to a CSV file.
    
    # read in the sound file
    sr, sounddata = scipy.io.wavfile.read(wavfile)
    
    # If the output file already exists,
    # use it to set coding_start_time to pick up where last left off,
    # and append to the output file rather than rewriting it.
    # If the output file does not already exist,
    # create it and the header line.
    if os.path.isfile(outfile):
        outf = open(outfile,'r')
        outfLines = outf.readlines()
        if len(outfLines)>1:
            lastOutfLine = outfLines[-1]
            coding_start_time = float(lastOutfLine.split(',')[1])
        else:
            coding_start_time = 0
        outf.close()
    else:
        outf = open(outfile,'w')
        outf.write('startSeconds,endSeconds,isTargetChild\n')
        outf.close()
        coding_start_time = 0
        
    segf = open(segmentsfile,'r')
    segfLines = segf.readlines()
    for segfLine in segfLines[1:]:
        segdata = segfLine.split(',')
        segtype = segdata[0]
        segstart = float(segdata[1])
        segend = float(segdata[2])
        if segstart >= coding_start_time and segtype[0:3]=='CHN':
            # play the segment and request user input
            segsounddata = sounddata[int(segstart*sr):int(segend*sr)]
            scipy.io.wavfile.write('temp.wav',sr,segsounddata)
            pygsound = pyglet.media.load('temp.wav',streaming=False)
            input(('\n***Instructions***\n\nListen carefully because you will '
                  'only get one opportunity to listen.\You will be asked '
                  'whether this is a non-ntirely vegetative vocalization by '
                  'the target child, with no other sounds (other than '
                  'low-volume background noise) present. Press return to play '
                  'the sound. To quit, press control+c.'))
            pygsound.play()
            userInput = input(('\nType y if this was indeed a non-vegetative '
                              'target child vocalization without other sounds '
                              '(other than low-volume background noise). '
                              'Otherwise you do not need to enter anything. '
                              'Then press return: '))
            isTargetChild = "y" in userInput
            outf = open(outfile,'a')
            outf.write(str(segstart) + ',' + str(segend) + ',' + str(isTargetChild) + '\n')
            outf.close()
    
    return
        
        
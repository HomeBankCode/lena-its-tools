import re
import sys
import os
from pydub import AudioSegment
import random
import pandas
import datetime

#_______________________________________________________________________________

def load_audio(audio):
    init = datetime.datetime.now()
    print("load audio")
    fullAudio = AudioSegment.from_wav(audio)
    print("audio loaded", datetime.datetime.now()-init)
    return fullAudio
#_______________________________________________________________________________

def find_all_chn(data):
    print("finding chn timestamps")
    list_timestamps = []
    for i in data:
        m1 = re.findall(r'spkr=\"CHN\"',i)
        m2 = re.findall(r'startTime=\"PT([0-9]+\.[0-9]+)S\"', i)
        m = re.findall(r'endTime=\"PT([0-9]+\.[0-9]+)?S\"', i)
        if ((m1 != []) & (m != []) & (m2 != [])):
            list_timestamps.append([m2[0],m[0]])
    print("list of chn timestamps complete")
    return list_timestamps
#_______________________________________________________________________________

def create_wav_chunks(timestamps, full_audio, audio_file):
    print("creating wav chunks")
    output_dir = '/'.join(audio_file.split('/')[:-1])+"/output/" # path to the output directory
    if not os.path.exists(output_dir):
        os.makedirs(output_dir) # creating the output directory if it does not exist
    audio_file_id = audio_file.split('/')[-1][:-4]
    for ts in timestamps:
        onset, offset = ts[0], ts[1]
        # print(ts)
        new_audio_chunk = full_audio[float(onset)*1000:float(offset)*1000]
        new_audio_chunk.export("{}_{}_{}.wav".format(output_dir+audio_file_id, onset, offset), format("wav"),bitrate="192k")
#_______________________________________________________________________________

def list_to_csv(list_ts, output_file): # to remember intermediaries
    df = pandas.DataFrame(list_ts, columns=["onset", "offset"]) # df of timestamps
    df.to_csv(output_file) # write dataframe to file
#_______________________________________________________________________________

def process_one_file(its_file, audio_file):
    with open(its_file) as f:
        data = f.readlines()
    f.close()

    full_audio = load_audio(audio_file) # load audio once
    all_chn_timestamps = find_all_chn(data) # get child timestamps
    # randomly sample 100 items from the last list
    chn100_timestamps = random.sample(all_chn_timestamps, 100)

    if len(sys.argv)>1:
        list_to_csv(all_chn_timestamps, its_file[:-4]+"_all_chn_timestamps.csv")
        list_to_csv(chn100_timestamps, its_file[:-4]+"_chn_100_timestamps.csv")

    create_wav_chunks(chn100_timestamps, full_audio, audio_file) # create 100 wav chunks
#_______________________________________________________________________________

if __name__ == "__main__":
    '''
    TODO: add argparse
    '''

    working_dir = sys.argv[1]

    for filename in os.listdir(working_dir):
        if filename.endswith(".its"):
            # its_file = sys.argv[1]
            its_file = working_dir+"/"+filename # path to its file (path/to/file.its)
            # audio_file = sys.argv[2]
            audio_file = working_dir+"/"+filename[:-4]+".wav" # path to audio file (path/to/audio_file.wav)
            if not os.path.exists(audio_file):
                print("file {} does not have its corresponding audio in the same directory - please place all files in the same directory and name its and wav file the same way (if the its file is called blabla.its, the wav file should be called blabla.wav)".format(its_file))
                continue
            process_one_file(its_file, audio_file)

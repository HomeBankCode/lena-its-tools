import re
import sys
import os
from pydub import AudioSegment
import random
import pandas
import datetime
from lxml import etree

#TODO
def get_corpus_child_id_from_spreadsheet(sc_file, its_file):
    sc_df = pandas.read_csv(sc_file)
    # only retrieve corpus and child id
    basename = its_file.split("/")[-1]
    print(basename)
    # get csv row with corresponding name
    corresponding_row = sc_df[sc_df['its_filename']==basename]
    # get corresponding child id
    child_id = corresponding_row['child_level_id'].iloc[0]
    corpus = corresponding_row['corpus'].iloc[0]
    return corpus, child_id

    pass

def get_age_in_days(its_file):
    with open(its_file) as f:
        data = f.read()
    f.close()
    # get recording date
    rec = re.findall(r'LocalTime=\"[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]', data)
    rec = [d.split('\"')[-1].split("-") for d in rec]
    rec_year, rec_month, rec_day = rec[0][0], rec[0][1], rec[0][2]
    # get date of birth
    dob = re.findall(r'dob=\"[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]', data)
    dob = [d.split('\"')[-1].split("-") for d in dob]
    dob_year, dob_month, dob_day = dob[0][0], dob[0][1], dob[0][2]
    # create date objects
    rec_date = datetime.date(int(rec_year), int(rec_month), int(rec_day))
    dob_date = datetime.date(int(dob_year), int(dob_month), int(dob_day))
    # return date difference
    return((rec_date-dob_date).days)

#_______________________________________________________________________________

def load_audio(audio):
    init = datetime.datetime.now()
    print("loading audio")
    fullAudio = AudioSegment.from_wav(audio)
    print("audio loaded in ", datetime.datetime.now()-init, " min.sec.ms")
    return fullAudio
#_______________________________________________________________________________

def find_all_chn_amanda(data, id='CHN'):
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

def extract_time(text):
    # removes PT and S from timestamp string and converts it to float
    return float(text[2:-1])

def find_all_chn(its_file, id="FAN"):
    chi_utt = []
    # parse as xml file
    xmldoc = etree.parse(its_file)
    # select all nodes that are segments
    for seg in xmldoc.iter('Segment'):
    # print(str(seg))
        if (seg.attrib['spkr']==id):
            # if segment spoken by CHN, retrieve the onset and offset of utterance
            # .attrib to get attribute from CHN node
            onset = extract_time(seg.attrib['startTime'])
            offset = extract_time(seg.attrib['endTime'])
            chi_utt.append([onset, offset])
    return chi_utt
#_______________________________________________________________________________

def create_wav_chunks(timestamps, full_audio, audio_file, corpus, age_in_days, child_id='child_id'):
    print("creating wav chunks")
    output_dir = '/'.join(audio_file.split('/')[:-1])+"/output/" # path to the output directory
    if not os.path.exists(output_dir):
        os.makedirs(output_dir) # creating the output directory if it does not exist
    # audio_file_id = audio_file.split('/')[-1][:-4]
    for ts in timestamps:
        onset, offset = ts[0], ts[1]
        # print(ts)
        new_audio_chunk = full_audio[float(onset)*1000:float(offset)*1000]
        new_audio_chunk.export("{}_{}_{}_{}_{}.wav".format(output_dir+corpus, child_id, str(age_in_days), onset, offset), format("wav"),bitrate="192k")
#_______________________________________________________________________________

def list_to_csv(list_ts, output_file): # to remember intermediaries
    df = pandas.DataFrame(list_ts, columns=["onset", "offset"]) # df of timestamps
    df.to_csv(output_file) # write dataframe to file
#_______________________________________________________________________________

def process_one_file(its_file, audio_file, spreadsheet):
    # with open(its_file) as f:
    #     data = f.readlines()
    # f.close()
    print(its_file)
    # TODO
    # get information
    # child_id = get_child_id(its_file)
    corpus, child_id = get_corpus_child_id_from_spreadsheet(spreadsheet, its_file)
    age_in_days = get_age_in_days(its_file)

    full_audio = load_audio(audio_file) # load audio once
    all_chn_timestamps = find_all_chn(its_file) # get child timestamps
    # randomly sample 100 items from the last list
    chn100_timestamps = random.sample(all_chn_timestamps, min(100,len(all_chn_timestamps)))

    if len(sys.argv)>2:
        list_to_csv(all_chn_timestamps, its_file[:-4]+"_all_chn_timestamps.csv")
        list_to_csv(chn100_timestamps, its_file[:-4]+"_chn_100_timestamps.csv")

    create_wav_chunks(chn100_timestamps, full_audio, audio_file, corpus, age_in_days, child_id) # create 100 wav chunks
#_______________________________________________________________________________

if __name__ == "__main__":
    '''
    TODO: add argparse
    '''

    working_dir = sys.argv[1]
    spreadsheet = sys.argv[2] # either name of corpus if the files have been renamed or the babblecorpus spreadsheet

    for filename in os.listdir(working_dir):
        if filename.endswith(".its"):
            # its_file = sys.argv[1]
            its_file = working_dir+"/"+filename # path to its file (path/to/file.its)
            # audio_file = sys.argv[2]
            audio_file = working_dir+"/"+filename[:-4]+".wav" # path to audio file (path/to/audio_file.wav)
            if not os.path.exists(audio_file):
                print("file {} does not have its corresponding audio in the same directory - please place all files in the same directory and name .its and .wav file the same way (if the .its file is called blabla.its, the .wav file should be called blabla.wav)".format(its_file))
                continue
            process_one_file(its_file, audio_file, working_dir+'/'+spreadsheet)
